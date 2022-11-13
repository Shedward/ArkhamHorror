//
//  DesignSystem+Font.swift
//  Arkham Horror
//
//  Created by Vladislav Maltsev on 08.08.2022.
//

extension DesignSystem {
    enum Font {
        static let titleSC = UFont(name: "VollkornSC-Bold", size: 24)!
        static let subtitleSC = UFont(name: "VollkornSC-SemiBold", size: 24)!
        static let subsubtitleSC = UFont(name: "VollkornSC-SemiBold", size: 20)!
        static let bodySC = UFont(name: "VollkornSC-Regular", size: 14)!
        static let keywordSC = UFont(name: "VollkornSC-Bold", size: 14)!
        static let title = UFont(name: "Vollkorn-Bold", size: 24)!
        static let subtitle = UFont(name: "Vollkorn-SemiBold", size: 24)!
        static let body = UFont(name: "Vollkorn-Regular", size: 14)!
        static let bodyItalic = UFont(name: "Vollkorn-Italic", size: 14)!
        static let keyword = UFont(name: "Vollkorn-Bold", size: 14)!
        static let debug = UFont(name: "Podkova-Regular", size: 14)!
    }
}

extension UFont {
    typealias Design = DesignSystem.Font
}
