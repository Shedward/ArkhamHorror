//
//  DesignSystem+Font.swift
//  Arkham Horror
//
//  Created by Vladislav Maltsev on 08.08.2022.
//

extension DesignSystem {
    enum Font {
        static let title = UFont(name: "VollkornSC-Bold", size: 18)!
        static let subtitle = UFont(name: "VollkornSC-SemiBold", size: 18)!
        static let body = UFont(name: "VollkornSC-Regular", size: 12)!
        static let keyword = UFont(name: "VollkornSC-Bold", size: 12)!
        static let debug = UFont(name: "Podkova-Regular", size: 12)!
    }
}

extension UFont {
    typealias Design = DesignSystem.Font
}

