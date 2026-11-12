//
//  TestData.swift
//  
//
//  Created by Vladislav Maltsev on 20.03.2022.
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

	func eventCardData(named: String) throws -> Data {
		try fileData(at: "events/\(named)")
	}

    func forEachEventCard(_ action: (URL, Result<Data, Swift.Error>) throws -> Void) throws {
        let eventsCardFolder = fileUrl(at: "events/")
        let fileManager = FileManager.default
        let files = try fileManager.contentsOfDirectory(
            at: eventsCardFolder,
            includingPropertiesForKeys: [.isDirectoryKey]
        )

        for file in files {
            let dataResult = Result { try Data(contentsOf: file) }
            try action(file, dataResult)
        }
    }
}
