//
//  MapDropDelegate.swift
//  Arkham Horror (macOS)
//
//  Created by Vladislav Maltsev on 16.01.2022.
//

import SwiftUI
import ArkhamHorror
import UniformTypeIdentifiers

final class MapDropDelegate: DropDelegate {
	static let supportedTypes: [UTType] = [.fileURL]

	enum Error: Swift.Error {
		case itemProviderFailedToLoadObject(Swift.Error)
		case failedToLoadFile(Swift.Error)
		case failedToParseFile(Swift.Error)
		case noKnownObjectFound
		case emptyCompletion
	}

	private let completion: (Result<Map, Error>) -> Void

	init(_ completion: @escaping (Result<Map, Error>) -> Void) {
		self.completion = completion
	}

	func performDrop(info: DropInfo) -> Bool {
		guard let fileProvider = info.itemProviders(for: [.fileURL]).first else {
			return false
		}
		
		if fileProvider.canLoadObject(ofClass: URL.self) {
			_ = fileProvider.loadObject(ofClass: URL.self) { url, error in
				let loadingResult = self.toResult(
					data: url,
					error: error,
					mapError: Error.itemProviderFailedToLoadObject
				)
				let mapResult = loadingResult.flatMap(self.loadMap)
				self.completion(mapResult)
			}
			return true
		}

		completion(.failure(.noKnownObjectFound))
		return true
	}

	private func loadMap(from url: URL) -> Result<Map, Error> {
		let data: Data
		do {
			data = try Data(contentsOf: url)
		} catch {
			return .failure(.failedToLoadFile(error))
		}

		let map: Map
		do {
			map = try Map(data: data)
		} catch {
			return .failure(.failedToParseFile(error))
		}

		return .success(map)
	}

	private func toResult<T>(
		data: T?,
		error: Swift.Error?,
		mapError: (Swift.Error) -> Error
	) -> Result<T, Error> {
		switch (data, error) {
		case (.some(let data), _):
			return .success(data)
		case (_, .some(let error)):
			return .failure(mapError(error))
		case (nil, nil):
			return .failure(.emptyCompletion)
		}
	}
}
