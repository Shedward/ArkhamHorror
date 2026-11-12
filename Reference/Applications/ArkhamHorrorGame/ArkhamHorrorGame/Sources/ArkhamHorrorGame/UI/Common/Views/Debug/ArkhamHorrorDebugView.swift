//
//  SwiftUIView.swift
//  
//
//  Created by Vladislav Maltsev on 27.11.2022.
//

import SwiftUI


struct DebugPreferenceKey: PreferenceKey {
    static var defaultValue: String = ""

    static func reduce(value: inout String, nextValue: () -> String) {
        value = nextValue()
    }
}

public struct ArkhamHorrorDebugView<Content: View>: View {

    @State private var preference: String?
    private let content: Content

    public init(@ViewBuilder content: () -> Content) {
        self.content = content()
    }

    public var body: some View {
        VStack {
            if let preference {
                Text(preference)
            } else {
                Text("Empty")
            }
            content
        }
        .onPreferenceChange(DebugPreferenceKey.self) { value in
            self.preference = value
        }
    }
}

struct ArkhamHorrorDebugView_Previews: PreviewProvider {
    static var previews: some View {
        ArkhamHorrorDebugView {
            VStack {
                Text("Hello world")
                    .preference(key: DebugPreferenceKey.self, value: "Hello")
                Text("Another hello")
                    .preference(key: DebugPreferenceKey.self, value: "Hello2")
            }
            .preference(key: DebugPreferenceKey.self, value: "Hello3")
        }
    }
}
