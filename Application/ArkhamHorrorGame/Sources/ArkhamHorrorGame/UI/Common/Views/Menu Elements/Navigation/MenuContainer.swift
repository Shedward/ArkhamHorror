//
//  MenuContainer.swift
//  
//
//  Created by Vladislav Maltsev on 27.11.2022.
//

import SwiftUI
import Prelude

struct MenuContainer: View {
    @State
    private var stack: [MenuNavigationItem]
    private let nextTransitionEdge: Box<Edge> = .init(.leading)

    init<Content: View>(@ViewBuilder content: () -> Content) {
        self.stack = [MenuNavigationItem(view: AnyView(content()))]
    }

    var body: some View {
        return VStack {
            stack.last?.view?
                .transition(.asymmetric(
                    insertion: .push(from: nextTransitionEdge.value),
                    removal: .opacity
                ))
            if stack.count > 1 {
                Button("Back") {
                    withAnimation {
                        nextTransitionEdge.value = .leading
                        stack = stack.dropLast()
                    }
                }
            }
        }
        .onPreferenceChange(MenuNavigationPreferenceKey.self) { navigation in
            if let navigation {
                withAnimation {
                    nextTransitionEdge.value = .trailing
                    stack.append(navigation)
                }
            }
        }
    }
}
