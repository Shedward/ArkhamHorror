//
//  DirectoryCampaignLoader.swift
//  
//
//  Created by Vladislav Maltsev on 14.11.2022.
//

import Foundation
import Prelude
import Yams

public enum DirectoryCampaignLoaderError: AppError {
    case notImplemented
    case failedToGetContentOfDirectory(Error)
    case failedToLoadCampaignFile(Error)
    case failedToLoadCharacters(Error)
    case failedToLoadCharacter(id: Character.Id, error: Error)
    case failedToParseCampaign(Error)
    case entityIdDifferentFromFileName(URL, String)
}

public final class DirectoryCampaignLoader: CampaignLoader {

    private let rootPath: URL
    private let fileManager: FileManager

    public init(rootPath: URL, fileManager: FileManager = .default) {
        self.rootPath = rootPath
        self.fileManager = fileManager
    }

    public func campaignsInfo() async throws -> [CampaignInfo] {
        try await Task(priority: .medium) { [self] in
            let directories = try mappingThrow(DirectoryCampaignLoaderError.failedToGetContentOfDirectory) {
                try self.fileManager.contentsOfDirectory(
                    at: self.rootPath,
                    includingPropertiesForKeys: [.isDirectoryKey]
                )
            }

            let campaignInfos = try directories.compactMap { campaignDir -> CampaignInfo? in
                let isDirectory = try? campaignDir.resourceValues(forKeys: [.isDirectoryKey]).isDirectory
                guard isDirectory ?? false else { return nil }
                let campaignId = Campaign.Id(rawValue:  campaignDir.lastPathComponent)

                let campaignInfoFile = fullPath(campaign: campaignId, path: Paths.campaignInfo)
                let campaignExists = fileManager.fileExists(atPath: campaignInfoFile.path)
                guard campaignExists else { return nil }

                let campaignInfo = try mappingThrow(DirectoryCampaignLoaderError.failedToParseCampaign) {
                    let campaignInfo = try loadFromFile(CampaignInfo.self, id: campaignId, path: Paths.campaignInfo)
                    try validateId(model: campaignInfo, fileUrl: campaignDir)
                    return campaignInfo
                }

                return campaignInfo
            }

            return campaignInfos
        }.value
    }

    public func loadCampaign(id campaignId: Campaign.Id) async throws -> Campaign {
        try await Task(priority: .medium) {
            let campaignInfo = try mappingThrow(DirectoryCampaignLoaderError.failedToParseCampaign) {
                try loadFromFile(CampaignInfo.self, id: campaignId, path: Paths.campaignInfo)
            }

            let characters: [Character] = try mappingThrow(DirectoryCampaignLoaderError.failedToLoadCharacters) {
                let allCharacterPath = fullPath(campaign: campaignId, path: Paths.allCharactersDir)
                let files = try fileManager.contentsOfDirectory(at: allCharacterPath, includingPropertiesForKeys: nil)
                let ymls = files.filter { $0.pathExtension == "yml" }

                let characters = try ymls.map { url -> Character in
                    let basename = url.deletingPathExtension().lastPathComponent
                    let characterId = Character.Id(rawValue: basename)

                    let character = try loadFromFile(Character.self, id: campaignId, path: Paths.character(id: characterId))
                    try validateId(model: character, fileUrl: url)
                    return character
                }

                return characters
            }

            return Campaign(
                info: campaignInfo,
                availableCharacters: characters
            )

        }.value
    }

    private func loadFromFile<Model: Decodable>(
        _ type: Model.Type,
        id campaignId: Campaign.Id,
        path: String
    ) throws -> Model {
        let filePath = fullPath(campaign: campaignId, path: path)
        let data = try Data(contentsOf: filePath)
        let decoder = YAMLDecoder()
        let resourceLoader = DirectoryResourceLoader(
            root: fullPath(campaign: campaignId, path: Paths.campaignRoot),
            fileManager: fileManager
        )
        let model = try decoder.decode(
            Model.self,
            from: data,
            userInfo: [ResourceLink.CodingUserInfoKey.resourceLoader: resourceLoader]
        )
        return model
    }

    private func fullPath(campaign: Campaign.Id, path: String) -> URL {
        rootPath
            .appendingPathComponent(campaign.rawValue)
            .appendingPathComponent(path)
    }

    private func validateId<Model: Identifiable>(
        model: Model,
        fileUrl: URL
    ) throws where Model.ID: CustomStringConvertible {
        let basename = fileUrl.deletingPathExtension().lastPathComponent
        let idString = String(describing: model.id)
        if basename != idString {
            throw DirectoryCampaignLoaderError.entityIdDifferentFromFileName(fileUrl, idString)
        }
    }
}

extension DirectoryCampaignLoader {
    private enum Paths {
        static let campaignRoot = ""
        static let campaignInfo = "campaign.yml"
        static let allCharactersDir = "characters"

        static func character(id: Character.Id) -> String {
            "characters/\(id.rawValue).yml"
        }
    }
}
