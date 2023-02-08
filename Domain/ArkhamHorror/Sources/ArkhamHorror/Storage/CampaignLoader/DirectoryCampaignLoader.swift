//
//  DirectoryCampaignLoader.swift
//  
//
//  Created by Vladislav Maltsev on 14.11.2022.
//

import Foundation
import Prelude
import Yams

public enum DirectoryCampaignLoaderError: Error {
    case notImplemented
    case failedToGetContentOfDirectory(Error)
    case failedToLoadCampaignFile(Error)
    case failedToParseCampaign(Error)
}

public final class DirectoryCampaignLoader: CampaignLoader {
    private let rootPath: URL
    private let fileManager: FileManager

    public init(rootPath: URL, fileManager: FileManager = .default) {
        self.rootPath = rootPath
        self.fileManager = fileManager
    }

    public func campaigns() async throws -> [CampaignDescription] {
        try await Task(priority: .medium) { [self] in
            let directories = try mappingThrow(DirectoryCampaignLoaderError.failedToGetContentOfDirectory) {
                try self.fileManager.contentsOfDirectory(
                    at: self.rootPath,
                    includingPropertiesForKeys: [.isDirectoryKey]
                )
            }

            let campaignDescriptions = try directories.compactMap { campaignDir -> CampaignDescription? in
                let isDirectory = try? campaignDir.resourceValues(forKeys: [.isDirectoryKey]).isDirectory
                guard isDirectory ?? false else { return nil }

                let campaignFile = campaignDir.appendingPathComponent("/campaign.yml")
                let campaignExists = fileManager.fileExists(atPath: campaignFile.path)
                guard campaignExists else { return nil }

                let campaignFileData = try mappingThrow(DirectoryCampaignLoaderError.failedToLoadCampaignFile) {
                    try Data(contentsOf: campaignFile)
                }

                let campaignDescription = try mappingThrow(DirectoryCampaignLoaderError.failedToParseCampaign) {
                    let decoder = YAMLDecoder()
                    let resourceLoader = DirectoryResourceLoader(root: campaignDir, fileManager: fileManager)
                    let model = try decoder.decode(
                        CampaignDescription.self,
                        from: campaignFileData,
                        userInfo: [ResourceLink.CodingUserInfoKey.resourceLoader: resourceLoader]
                    )
                    return model
                }

                return campaignDescription
            }

            return campaignDescriptions
        }.value
    }

    public func loadCampaign(id: Campaign.Id) async throws -> Campaign {
        throw DirectoryCampaignLoaderError.notImplemented
    }
}
