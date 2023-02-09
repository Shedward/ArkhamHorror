//
//  DesignSystem+Font.swift
//  Arkham Horror
//
//  Created by Vladislav Maltsev on 08.08.2022.
//

extension DesignSystem {
    public enum Font {
        public static let titleSC = UFont(name: "VollkornSC-Bold", size: 24)!
        public static let subtitleSC = UFont(name: "VollkornSC-SemiBold", size: 24)!
        public static let subsubtitleSC = UFont(name: "VollkornSC-SemiBold", size: 20)!
        public static let bodySC = UFont(name: "VollkornSC-Regular", size: 14)!
        public static let keywordSC = UFont(name: "VollkornSC-Bold", size: 14)!
        public static let title = UFont(name: "Vollkorn-Bold", size: 24)!
        public static let subtitle = UFont(name: "Vollkorn-SemiBold", size: 24)!
        public static let body = UFont(name: "Vollkorn-Regular", size: 14)!
        public static let bodyItalic = UFont(name: "Vollkorn-Italic", size: 14)!
        public static let keyword = UFont(name: "Vollkorn-Bold", size: 14)!
        public static let debug = UFont(name: "Podkova-Regular", size: 14)!
    }
}

extension UFont {
    public typealias Design = DesignSystem.Font
}
