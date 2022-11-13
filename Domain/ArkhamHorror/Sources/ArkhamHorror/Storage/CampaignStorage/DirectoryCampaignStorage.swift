//
//  DirectoryCampaignStorage.swift
//  
//
//  Created by Vladislav Maltsev on 14.11.2022.
//

import Foundation

public enum DirectoryCampaignStorageError: Error {
    case rootPathNotFound
    case notImplemented
}

public final class DirectoryCampaignStorage: CampaignStorage {
    private let rootPath: URL
    private let fileManager: FileManager

    init(rootPath: URL, fileManager: FileManager = .default) {
        self.rootPath = rootPath
        self.fileManager = fileManager
    }

    public func campaigns() async throws -> [CampaignDescription] {
        throw DirectoryCampaignStorageError.notImplemented
    }

    public func loadCampaign(id: Campaign.Id) async throws -> Campaign {
        throw DirectoryCampaignStorageError.notImplemented
    }
}
