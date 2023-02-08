//
//  ResourceLoader.swift
//  
//
//  Created by Vladislav Maltsev on 08.02.2023.
//

import Foundation

public protocol ResourceLoader {
    func linkExists(at path: String) -> Bool
    func loadResource(at path: String) async throws -> Data

    func sameAs(_ another: ResourceLoader) -> Bool
}
