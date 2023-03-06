//
//  Color.swift
//  
//
//  Created by Vladislav Maltsev on 06.03.2023.
//

import Foundation
import Prelude

public struct Color: Codable, Equatable {
    public var red: UInt
    public var green: UInt
    public var blue: UInt
    public var alpha: UInt

    public var isGrayscale: Bool {
        red == green && green == blue
    }

    public var isValid: Bool {
        return red <= 255
        && green <= 255
        && blue <= 255
        && alpha <= 255
    }

    public init(red: UInt, green: UInt, blue: UInt, alpha: UInt = 0xFF) throws {
        self.red = red
        self.green = green
        self.blue = blue
        self.alpha = alpha

        guard isValid else {
            throw AppError("Invalid color \(self)")
        }
    }

    public init(string: String) throws {
        var cleanRawValue = string
            .trimmingCharacters(in: .whitespacesAndNewlines)
            .uppercased()

        if (cleanRawValue.hasPrefix("#")) {
            cleanRawValue = String(cleanRawValue.dropFirst())
        }

        var rgbValue: UInt64 = 0
        let scanner = Scanner(string: cleanRawValue)
        let success = scanner.scanHexInt64(&rgbValue)
        guard success, scanner.isAtEnd else {
            throw AppError("Value \(string) is not a valid color")
        }

        var red: UInt64 = 0x00
        var green: UInt64 = 0x00
        var blue: UInt64 = 0x00
        var alpha: UInt64 = 0xFF

        let h0 = (rgbValue & 0x000000FF) >> 0
        let h1 = (rgbValue & 0x0000FF00) >> 8
        let h2 = (rgbValue & 0x00FF0000) >> 16
        let h3 = (rgbValue & 0xFF000000) >> 24

        switch cleanRawValue.count {
        case 2:
            red = h0
            green = h0
            blue = h0
        case 4:
            red = h1
            green = h1
            blue = h1
            alpha = h0
        case 6:
            red = h2
            green = h1
            blue = h0
        case 8:
            red = h3
            green = h2
            blue = h1
            alpha = h0
        default:
            throw AppError("Value \(string) is not a valid color")
        }

        self.red = UInt(red)
        self.green = UInt(green)
        self.blue = UInt(blue)
        self.alpha = UInt(alpha)

        guard isValid else {
            throw AppError("Invalid color result \(string) from \(string)")
        }
    }

    public func toString() -> String {
        var string: String = "#"
        func appendValue(_ value: UInt) {
            string += String(format: "%02x", value)
        }

        if isGrayscale {
            appendValue(red)
        } else {
            appendValue(red)
            appendValue(green)
            appendValue(blue)
        }

        if alpha < 255 {
            appendValue(alpha)
        }

        return string
    }

    public init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        let string = try container.decode(String.self)
        try self.init(string: string)
    }

    public func encode(to encoder: Encoder) throws {
        guard isValid else {
            throw AppError("Invalid color \(self)")
        }

        var container = encoder.singleValueContainer()
        let string = toString()
        try container.encode(string)
    }
}
