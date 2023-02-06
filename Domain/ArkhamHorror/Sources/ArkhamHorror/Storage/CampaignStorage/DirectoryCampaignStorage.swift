//
//  DirectoryCampaignStorage.swift
//  
//
//  Created by Vladislav Maltsev on 14.11.2022.
//

import Foundation
import Prelude
import Yams

public enum DirectoryCampaignStorageError: Error {
    case notImplemented
    case failedToGetContentOfDirectory(Error)
    case failedToLoadCampaignFile(Error)
    case failedToParseCampaign(Error)
}

public final class DirectoryCampaignStorage: CampaignStorage {
    private let rootPath: URL
    private let fileManager: FileManager

    public init(rootPath: URL, fileManager: FileManager = .default) {
        self.rootPath = rootPath
        self.fileManager = fileManager
    }

    public func campaigns() async throws -> [CampaignDescription] {
        try await Task(priority: .medium) {
            let directories = try mappingThrow(DirectoryCampaignStorageError.failedToGetContentOfDirectory) {
                try fileManager.contentsOfDirectory(
                    at: rootPath,
                    includingPropertiesForKeys: [.isDirectoryKey]
                )
            }

            let campaignDescriptions = try directories.compactMap { campaignDir -> CampaignDescription? in
                let isDirectory = try? campaignDir.resourceValues(forKeys: [.isDirectoryKey]).isDirectory
                guard isDirectory ?? false else { return nil }

                let campaignFile = campaignDir.appendingPathComponent("/campaign.yml")
                let campaignExists = fileManager.fileExists(atPath: campaignFile.path)
                guard campaignExists else { return nil }

                let campaignFileData = try mappingThrow(DirectoryCampaignStorageError.failedToLoadCampaignFile) {
                    try Data(contentsOf: campaignFile)
                }
                let campaignDescription = try mappingThrow(DirectoryCampaignStorageError.failedToParseCampaign) {
                    let decoder = YAMLDecoder()
                    let model = try decoder.decode(
                        CampaignDescription.self,
                        from: campaignFileData,
                        userInfo: [ResourceLink.CodingUserInfoKey.resourcePrefix: campaignDir]
                    )
                    return model
                }

                return campaignDescription
            }

            return campaignDescriptions
        }.value
    }

    public func loadCampaign(id: Campaign.Id) async throws -> Campaign {
        throw DirectoryCampaignStorageError.notImplemented
    }
}
