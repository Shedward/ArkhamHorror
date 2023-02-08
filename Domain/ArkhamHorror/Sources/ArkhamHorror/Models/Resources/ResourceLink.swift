//
//  ResourceLink.swift
//  
//
//  Created by Vladislav Maltsev on 06.02.2023.
//

import Foundation

public struct ResourceLink: Codable {
    private let resourceLoader: ResourceLoader
    public var path: String

    init(resourceLoader: ResourceLoader, path: String) {
        self.resourceLoader = resourceLoader
        self.path = path
    }

    public init(from decoder: Decoder) throws {
        guard let resourceLoaderAny = decoder.userInfo[CodingUserInfoKey.resourceLoader] else {
            throw CodingError.resourceLoaderNotProvided
        }

        guard let resourceLoader = resourceLoaderAny as? ResourceLoader else {
            throw CodingError.wrongResourceLoader
        }

        let container = try decoder.singleValueContainer()
        let rawValue = try container.decode(String.self)

        guard rawValue.starts(with: "//") else {
            throw CodingError.badLinkFormat(rawLink: rawValue)
        }

        let path = String(rawValue.dropFirst(2))

        guard resourceLoader.linkExists(at: path) else {
            throw CodingError.resourceNotExists(path: path)
        }

        self.init(resourceLoader: resourceLoader, path: path)
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        let rawValue = "//\(path)"
        try container.encode(rawValue)
    }

    public func load() async throws -> Data {
        try await resourceLoader.loadResource(at: path)
    }
}

extension ResourceLink: Equatable {
    public static func == (lhs: ResourceLink, rhs: ResourceLink) -> Bool {
        lhs.path == rhs.path && lhs.resourceLoader.sameAs(rhs.resourceLoader)
    }
}

extension ResourceLink {
    public enum CodingError: Error {
        case resourceLoaderNotProvided
        case wrongResourceLoader
        case resourceNotExists(path: String)
        case badLinkFormat(rawLink: String)
    }

    public enum CodingUserInfoKey {
        public static let resourceLoader = Swift.CodingUserInfoKey(rawValue: "resourceLink.resourceLoader")!
    }
}
