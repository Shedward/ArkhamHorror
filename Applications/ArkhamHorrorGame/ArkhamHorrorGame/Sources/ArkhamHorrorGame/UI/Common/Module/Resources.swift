//
//  Module.swift
//  
//
//  Created by Vladislav Maltsev on 06.02.2023.
//

import Foundation

public enum Resources {
    public static let bundle = Bundle.module

    public static var campaignDirectory: URL? {
        let path = bundle.resourcePath?.appending("/Campaigns")
        return path.map { URL(filePath: $0) }
    }
}
