//
//  MenuContainer.swift
//  
//
//  Created by Vladislav Maltsev on 27.11.2022.
//

import SwiftUI
import Prelude

public struct MenuContainer: View {
    @State private var stack: [MenuNavigationItem]
    @State private var title: String?

    private let nextTransitionEdge: Box<Edge> = .init(.leading)

    public init<Content: View>(@ViewBuilder content: () -> Content) {
        self.stack = [MenuNavigationItem(view: AnyView(content()))]
    }

    public var body: some View {
        return VStack {
            ZStack(alignment: .bottomLeading) {
                ZStack(alignment: .center) {
                    Rectangle()
                        .fill(Color(.Design.Background.main))
                        .ignoresSafeArea()
                    VStack(spacing: 32) {
                        if let title {
                            VStack(spacing: 0) {
                                Text(title)
                                    .styled(.Design.Menu.h1)
                                MenuHSeparator().frame(maxWidth: 200)
                            }
                            .withoutAnimation()
                        }
                        stack.last?.view?
                            .transition(transition)
                            .padding([.leading, .trailing, .bottom], 32)
                    }
                    .padding()
                }
                if stack.count > 1 {
                    MenuButton(title: Localized.string("Back"), icons: .leftIcon("arrow.backward"))
                        .onTapGesture{
                            withAnimation {
                                nextTransitionEdge.value = .leading
                                stack = stack.dropLast()
                            }
                        }
                        .transition(transition)
                        .padding(EdgeInsets(top: 0, leading: 32, bottom: 24, trailing: 0))
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
        .onPreferenceChange(MenuTitlePreferenceKey.self) { title in
            withAnimation {
                self.title = title
            }
        }
    }

    var transition: AnyTransition {
        .asymmetric(
            insertion: .push(from: nextTransitionEdge.value),
            removal: .opacity
        )
    }
}
