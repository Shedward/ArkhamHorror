//
//  UIColor+Ext.swift
//  Arkham Horror
//
//  Created by Vladislav Maltsev on 03.08.2022.
//

import CoreGraphics
import HSLuvSwift
import ArkhamHorror

extension UColor {
    public convenience init(red: Int, green: Int, blue: Int, alpha: Int = 255) {
        assert(red >= 0 && red <= 255, "Invalid red component")
        assert(green >= 0 && green <= 255, "Invalid green component")
        assert(blue >= 0 && blue <= 255, "Invalid blue component")

        self.init(red: CGFloat(red) / 255.0, green: CGFloat(green) / 255.0, blue: CGFloat(blue) / 255.0, alpha: CGFloat(alpha) / 255.0)
    }

    public convenience init(rgb: Int, alpha: Int = 255) {
        self.init(
            red: (rgb >> 16) & 0xFF,
            green: (rgb >> 8) & 0xFF,
            blue: rgb & 0xFF,
            alpha: alpha
        )
    }

    public convenience init<T: Hashable>(
        randomForHashOf object: T,
        saturation: Double = 100.0,
        lightness: Double = 50.0,
        alpha: Double = 1.0,
        usePastelSaturation: Bool = false
    ) {
        if usePastelSaturation {
            self.init(
                hue: Double.hashRandom(from: 0.0, to: 360.0, for: object),
                pastelSaturation: saturation,
                lightness: lightness,
                alpha: alpha
            )
        } else {
            self.init(
                hue: Double.hashRandom(from: 0.0, to: 360.0, for: object),
                saturation: saturation,
                lightness: lightness,
                alpha: alpha
            )
        }
    }
}

extension ArkhamHorror.Color {
    public func toUColor() -> UColor {
        UColor(red: Int(red), green: Int(green), blue: Int(blue), alpha: Int(alpha))
    }
}
