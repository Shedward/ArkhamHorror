//
//  Range+Helpers.swift
//  Prelude
//
//  Created by Vlad Maltsev on 07.05.2025.
//

@inlinable
public func clamp <T: Comparable> (_ value: T, min: T, max: T) -> T {
    if value > max {
        return max
    }

    if value < min {
        return min
    }

    return value
}

@inlinable
public func clamp <T: Comparable> (_ value: T, in range: ClosedRange<T>) -> T {
    clamp(value, min: range.lowerBound, max: range.upperBound)
}

extension ClosedRange {
    @inlinable
    public func clamp(_ value: Bound) -> Bound {
        Prelude.clamp(value, min: lowerBound, max: upperBound)
    }
}

extension ClosedRange where Bound: BinaryFloatingPoint {
    @inlinable
    public func lerp(_ value: Bound) -> Bound {
        let value = Prelude.clamp(value, min: 0.0, max: 1.0)
        return lowerBound + (upperBound - lowerBound) * value
    }

    @inlinable
    public func remap(_ value: Bound, to targetRange: ClosedRange<Bound>, clamp: Bool = false) -> Bound {
        guard self.lowerBound != self.upperBound else { return targetRange.lowerBound }

        var value = value
        if clamp {
            value = Prelude.clamp(value, min: self.lowerBound, max: self.upperBound)
        }

        let t = (value - self.lowerBound) / (self.upperBound - self.lowerBound)
        return targetRange.lowerBound + t * (targetRange.upperBound - targetRange.lowerBound)
    }
}
