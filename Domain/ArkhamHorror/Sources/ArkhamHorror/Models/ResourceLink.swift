//
//  ResourceLink.swift
//  
//
//  Created by Vladislav Maltsev on 06.02.2023.
//

import Foundation

public struct ResourceLink: Codable, Equatable {
    public var prefix: String
    public var path: String

    public var fullPath: URL {
        URL(string: prefix)!.appendingPathComponent(path)
    }

    public init(prefix: String, path: String) throws {
        guard URL(string: prefix) != nil else {
            throw CodingError.prefixIsInvalid(prefix: prefix)
        }
        guard URL(string: path) != nil else {
            throw CodingError.pathIsInvalid(path: path)
        }

        self.prefix = prefix
        self.path = path
    }

    public init(from decoder: Decoder) throws {
        guard let resourcePrefixAny = decoder.userInfo[CodingUserInfoKey.resourcePrefix] else {
            throw CodingError.resourcePrefixNotProvided
        }

        guard let resourcePrefix = resourcePrefixAny as? String else {
            throw CodingError.resourcePrefixNotProvided
        }

        let container = try decoder.singleValueContainer()
        let rawValue = try container.decode(String.self)

        guard rawValue.starts(with: "//") else {
            throw CodingError.badLinkFormat(rawLink: rawValue)
        }

        let path = String(rawValue.dropFirst(2))

        try self.init(prefix: resourcePrefix, path: path)
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        let rawValue = "//\(path)"
        try container.encode(rawValue)
    }
}

extension ResourceLink {
    public enum CodingError: Error {
        case resourcePrefixNotProvided
        case resourcePrefixIsNotString
        case prefixIsInvalid(prefix: String)
        case pathIsInvalid(path: String)
        case badLinkFormat(rawLink: String)
    }

    public enum CodingUserInfoKey {
        public static let resourcePrefix = Swift.CodingUserInfoKey(rawValue: "resourceLink.resourcePrefix")!
    }
}
