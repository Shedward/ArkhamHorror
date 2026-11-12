//
//  Loading.swift
//  
//
//  Created by Vladislav Maltsev on 11.02.2023.
//

public enum Loading<T> {
    case loading
    case loaded(T)
    case failed(Error)

    public var value: T? {
        if case .loaded(let t) = self {
            return t
        } else {
            return nil
        }
    }

    public var error: Error? {
        if case .failed(let error) = self {
            return error
        } else {
            return nil
        }
    }

    public static func `async`(_ call: () async throws -> T) async -> Loading<T> {
        do {
            let result = try await call()
            return .loaded(result)
        } catch {
            return .failed(error)
        }
    }

    public func map<V>(_ transform: (T) -> V) -> Loading<V> {
        switch self {
        case .loaded(let t):
            return .loaded(transform(t))
        case .loading:
            return .loading
        case .failed(let error):
            return .failed(error)
        }
    }

    public func mapError(_ transform: (Error) -> Error) -> Loading<T> {
        switch self {
        case .failed(let error):
            return .failed(transform(error))
        case .loading, .loaded:
            return self
        }
    }
}
