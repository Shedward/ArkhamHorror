//
//  ImageResource.swift
//  
//
//  Created by Vladislav Maltsev on 08.02.2023.
//

#if os(macOS)
import AppKit
public typealias UImage = NSImage
#else
import UIKit
public typealias UImage = UIImage
#endif

import Prelude
import SpriteKit

public struct ImageResource: Codable {
    private let link: ResourceLink
    private let logger = Logger()

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

    public func load() throws -> UImage {
        let data = try link.load()
        if let image = UImage(data: data) {
            return image
        } else {
            throw AppError("Failed to load image from \(data)")
        }
    }

    public func loadTexture() -> SKTexture {
        do {
            let data = try link.load()
            guard let image = UImage(data: data) else {
                throw AppError("Failed to parse data \(data) as an Image for resource at \(link)")
            }
            let texture = SKTexture(image: image)
            return texture
        } catch {
            logger.error("""
            Failed to load a texture from \(self): \
            \(error)
            """)
            return SKTexture()
        }
    }
}

