//
//  MenuContainer.swift
//  
//
//  Created by Vladislav Maltsev on 27.11.2022.
//

import SwiftUI
import Prelude

public struct MenuContainer: View {
    @State
    private var pageProperties: MenuPageProperties = .init()
    @State
    private var stack: [MenuNavigationItem]

    private let nextTransitionEdge: Box<Edge> = .init(.leading)

    public init<Content: View>(@ViewBuilder content: () -> Content) {
        stack = [.init(view: AnyView(content()))]
    }

    public var body: some View {
        VStack {
            ZStack(alignment: .bottomLeading) {
                ZStack(alignment: .center) {
                    Rectangle()
                        .fill(Color(.Design.Background.main))
                        .ignoresSafeArea()
                    VStack(spacing: 32) {
                        if let title = pageProperties.title {
                            VStack(spacing: 0) {
                                Text(title)
                                    .styled(.Design.Menu.h1)
                                MenuHSeparator().frame(maxWidth: 200)
                            }
                            .withoutAnimation()
                        }
                        stack.last?.view?
                            .withoutAnimation()
                            .padding([.leading, .trailing], 32)
                            .padding([.top], pageProperties.title != nil ? 0 : 32 )
                            .padding([.bottom], shoudlShowBackButton ? 0 : 32)
                    }
                }
                .transition(transition)
                if shoudlShowBackButton {
                    MenuButton(title: Localized.string("Back"), icons: .leftIcon("arrow.backward"))
                        .onTapGesture{
                            withTransitionAnimations {
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
                withTransitionAnimations {
                    nextTransitionEdge.value = .trailing
                    stack.append(navigation)
                }
            }
        }
        .onPreferenceChange(MenuPagePropertiesPreferenceKey.self) { pageProperties in
            withTransitionAnimations {
                self.pageProperties = pageProperties ?? .init()
            }
        }
    }

    var shoudlShowBackButton: Bool {
        stack.count > 1 && pageProperties.showBackButton
    }

    var transition: AnyTransition {
        .opacity
    }

    func withTransitionAnimations(_ actions: () -> Void) {
        withAnimation(.easeIn(duration: 0.125), actions)
    }
}
