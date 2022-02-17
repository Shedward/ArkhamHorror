//
//  TestData.swift
//  
//
//  Created by Vladislav Maltsev on 09.01.2022.
//

import Foundation

struct TestData {
	enum Error: Swift.Error {
		case failedToGetResourcePath
	}

	private let testDataUrl: URL
	
	init() throws {
		let bundle = Bundle.module
		guard let resourcePath = bundle.resourcePath else {
			throw Error.failedToGetResourcePath
		}
		let resourceUrl =  URL(fileURLWithPath: resourcePath)
		testDataUrl = resourceUrl.appendingPathComponent("TestData")
	}

	func fileUrl(at path: String) -> URL {
		testDataUrl.appendingPathComponent(path)
	}

	func fileData(at path: String) throws -> Data {
		let fileUrl = self.fileUrl(at: path)
		let data = try Data(contentsOf: fileUrl)
		return data
	}

	func mapData() throws -> Data {
		try fileData(at: "map.json")
	}
}
