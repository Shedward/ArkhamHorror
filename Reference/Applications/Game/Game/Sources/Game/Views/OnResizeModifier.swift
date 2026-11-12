//
//  OnResizeModifier.swift
//  Game
//
//  Created by Vlad Maltsev on 07.05.2025.
//

import SwiftUI

struct OnResizeModifier: ViewModifier {
    var onChange: (CGSize) -> Void

    func body(content: Content) -> some View {
        content
            .background(
                GeometryReader { proxy in
                    Color.clear
                        .preference(key: SizePreferenceKey.self, value: proxy.size)
                }
            )
            .onPreferenceChange(SizePreferenceKey.self, perform: onChange)
    }
}

private struct SizePreferenceKey: PreferenceKey {
    static var defaultValue: CGSize = .zero
    static func reduce(value: inout CGSize, nextValue: () -> CGSize) {
        value = nextValue()
    }
}

extension View {
    func onResize(_ onChange: @escaping (CGSize) -> Void) -> some View {
        self.modifier(OnResizeModifier(onChange: onChange))
    }
}
