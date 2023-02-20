//
//  simd+Helpers.swift
//  
//
//  Created by Vladislav Maltsev on 16.02.2023.
//

import simd

extension vector_float3 {

    @inlinable
    public init(uniform: Float) {
        self.init(uniform, uniform, uniform)
    }

    @inlinable
    public func movedBy(dx: Float = 0, dy: Float = 0, dz: Float = 0) -> vector_float3 {
        self + vector_float3(dx, dy, dz)
    }

    @inlinable
    public func with(z: Float) -> vector_float3 {
        var v = self
        v.z = z
        return v
    }
}
