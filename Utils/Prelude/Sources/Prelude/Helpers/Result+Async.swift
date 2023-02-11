//
//  Result+Async.swift
//  
//
//  Created by Vladislav Maltsev on 11.02.2023.
//

import Foundation

public func asyncResult<Success>(_ call: () async throws -> Success) async -> Result<Success, Error> {
    do {
        let result = try await call()
        return .success(result)
    } catch {
        return .failure(error)
    }
}
