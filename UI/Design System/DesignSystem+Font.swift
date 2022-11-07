//
//  DesignSystem+Font.swift
//  Arkham Horror
//
//  Created by Vladislav Maltsev on 08.08.2022.
//

extension DesignSystem {
    enum Font {
        static let titleSC = UFont(name: "VollkornSC-Bold", size: 18)!
        static let subtitleSC = UFont(name: "VollkornSC-SemiBold", size: 18)!
        static let bodySC = UFont(name: "VollkornSC-Regular", size: 12)!
        static let keywordSC = UFont(name: "VollkornSC-Bold", size: 12)!
        static let title = UFont(name: "Vollkorn-Bold", size: 18)!
        static let subtitle = UFont(name: "Vollkorn-SemiBold", size: 18)!
        static let body = UFont(name: "Vollkorn-Regular", size: 12)!
        static let keyword = UFont(name: "Vollkorn-Bold", size: 12)!
        static let debug = UFont(name: "Podkova-Regular", size: 12)!
    }
}

extension UFont {
    typealias Design = DesignSystem.Font
}

