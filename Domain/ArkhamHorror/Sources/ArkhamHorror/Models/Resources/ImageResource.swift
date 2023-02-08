//
//  ImageResource.swift
//  
//
//  Created by Vladislav Maltsev on 08.02.2023.
//

#if os(macOS)
import AppKit
typealias UImage = NSImage
#else
import UIKit
typealias UImage = UIImage
#endif

public enum ImageResourceError: Error {
    case unsuportedFileType(String)
    case failedToLoadImage
}

public struct ImageResource: Codable {
    private let link: ResourceLink

    init(link: ResourceLink) {
        self.link = link
    }

    public init(from decoder: Decoder) throws {
        let link = try ResourceLink(from: decoder)
        self.link = link
    }

    public func encode(to encoder: Encoder) throws {
        try link.encode(to: encoder)
    }

    func load() async throws -> UImage {
        let data = try await link.load()
        if let image = UImage(data: data) {
            return image
        } else {
            throw ImageResourceError.failedToLoadImage
        }
    }
}

