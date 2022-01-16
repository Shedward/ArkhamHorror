//
//  RawRecord.swift
//  
//
//  Created by Vladislav Maltsev on 02.01.2022.
//

public struct Tagged<Tag, RawValue> {
	public var rawValue: RawValue

	public init(rawValue: RawValue) {
		self.rawValue = rawValue
	}

	public func map<B>(_ f: (RawValue) -> B) -> Tagged<Tag, B> {
		return .init(rawValue: f(self.rawValue))
	}
}

extension Tagged: Equatable where RawValue: Equatable {
}

extension Tagged: Decodable where RawValue: Decodable {
	public init(from decoder: Decoder) throws {
		do {
			self.init(rawValue: try decoder.singleValueContainer().decode(RawValue.self))
		} catch {
			self.init(rawValue: try .init(from: decoder))
		}
	}
}

extension Tagged: Encodable where RawValue: Encodable {
	public func encode(to encoder: Encoder) throws {
		var container = encoder.singleValueContainer()
		try container.encode(self.rawValue)
	}
}

extension Tagged: ExpressibleByBooleanLiteral where RawValue: ExpressibleByBooleanLiteral {
	public typealias BooleanLiteralType = RawValue.BooleanLiteralType

	public init(booleanLiteral value: RawValue.BooleanLiteralType) {
		self.init(rawValue: RawValue(booleanLiteral: value))
	}
}

extension Tagged: ExpressibleByExtendedGraphemeClusterLiteral where RawValue: ExpressibleByExtendedGraphemeClusterLiteral {
	public typealias ExtendedGraphemeClusterLiteralType = RawValue.ExtendedGraphemeClusterLiteralType

	public init(extendedGraphemeClusterLiteral: ExtendedGraphemeClusterLiteralType) {
		self.init(rawValue: RawValue(extendedGraphemeClusterLiteral: extendedGraphemeClusterLiteral))
	}
}

extension Tagged: ExpressibleByFloatLiteral where RawValue: ExpressibleByFloatLiteral {
	public typealias FloatLiteralType = RawValue.FloatLiteralType

	public init(floatLiteral: FloatLiteralType) {
		self.init(rawValue: RawValue(floatLiteral: floatLiteral))
	}
}

extension Tagged: ExpressibleByIntegerLiteral where RawValue: ExpressibleByIntegerLiteral {
	public typealias IntegerLiteralType = RawValue.IntegerLiteralType

	public init(integerLiteral: IntegerLiteralType) {
		self.init(rawValue: RawValue(integerLiteral: integerLiteral))
	}
}

extension Tagged: ExpressibleByStringLiteral where RawValue: ExpressibleByStringLiteral {
	public typealias StringLiteralType = RawValue.StringLiteralType

	public init(stringLiteral: StringLiteralType) {
		self.init(rawValue: RawValue(stringLiteral: stringLiteral))
	}
}

extension Tagged: ExpressibleByStringInterpolation where RawValue: ExpressibleByStringInterpolation {
	public typealias StringInterpolation = RawValue.StringInterpolation

	public init(stringInterpolation: Self.StringInterpolation) {
		self.init(rawValue: RawValue(stringInterpolation: stringInterpolation))
	}
}

extension Tagged: ExpressibleByUnicodeScalarLiteral where RawValue: ExpressibleByUnicodeScalarLiteral {
	public typealias UnicodeScalarLiteralType = RawValue.UnicodeScalarLiteralType

	public init(unicodeScalarLiteral: UnicodeScalarLiteralType) {
		self.init(rawValue: RawValue(unicodeScalarLiteral: unicodeScalarLiteral))
	}
}

extension Tagged: Hashable where RawValue: Hashable {
	public var hashValue: Int {
		rawValue.hashValue
	}

	public func hash(into hasher: inout Hasher) {
		 rawValue.hash(into: &hasher)
	}
}
