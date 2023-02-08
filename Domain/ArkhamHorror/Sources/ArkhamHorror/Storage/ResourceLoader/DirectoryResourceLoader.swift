//
//  DirectoryResourceLoader.swift
//  
//
//  Created by Vladislav Maltsev on 08.02.2023.
//

import Foundation

enum DirectoryResourceLoaderError: Error {
    case fileForResourceNotFound(URL)
}

public final class DirectoryResourceLoader: ResourceLoader {
    private let root: URL
    private let fileManager: FileManager

    var allowLinksToNonExistentFiles: Bool = false

    public init(root: URL, fileManager: FileManager = .default) {
        self.root = root
        self.fileManager = fileManager
    }

    public func linkExists(at path: String) -> Bool {
        if allowLinksToNonExistentFiles {
            return true
        }

        let url = root.appendingPathComponent(path)
        return fileManager.fileExists(atPath: url.path)
    }

    public func loadResource(at path: String) async throws -> Data {
        try await Task(priority: .userInitiated) {
            let url = root.appendingPathComponent(path)
            return try Data(contentsOf: url)
        }.value
    }

    public func sameAs(_ another: ResourceLoader) -> Bool {
        guard let another = another as? DirectoryResourceLoader else { return false }
        return another.root == root
    }
}
