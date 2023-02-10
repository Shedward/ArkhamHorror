//
//  InMemoryResourceLoader.swift
//  
//
//  Created by Vladislav Maltsev on 08.02.2023.
//

import Foundation
import Prelude

public final class InMemoryResourceLoader: ResourceLoader {
    private var resources: [String: Data]

    public init(resources: [String: Data] = [:]) {
        self.resources = resources
    }

    public func addResource(_ data: Data, to path: String) {
        resources[path] = data
    }

    public func removeResource(from path: String) {
        resources.removeValue(forKey: path)
    }

    public func linkExists(at path: String) -> Bool {
        resources.keys.contains(path)
    }

    public func loadResource(at path: String) async throws -> Data {
        if let data = resources[path] {
            return data
        } else {
            throw AppError("Resource at \(path) not found")
        }
    }

    public func sameAs(_ another: ResourceLoader) -> Bool {
        guard let another = another as? InMemoryResourceLoader else {
            return false
        }

        return self === another
    }
}
