//
//  MappingThrow.swift
//  
//
//  Created by Vladislav Maltsev on 06.02.2023.
//

public func mappingThrow<Return>(
    _ mapError: (Error) -> Error,
    action: () throws -> Return
) throws -> Return {
    do {
        return try action()
    } catch {
        throw mapError(error)
    }
}
