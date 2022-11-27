//
//  SwiftUIView.swift
//  
//
//  Created by Vladislav Maltsev on 27.11.2022.
//

import SwiftUI

public struct ArkhamHorrorDebugView: View {

    public init() {
    }

    public var body: some View {
        MenuContainer {
            VStack {
                MenuLink {
                    MenuButton(title: "Rectangle", icons: .rightIcon("arrow.forward"))
                } content: {
                    Rectangle()
                        .frame(width: 50, height: 50)
                        .foregroundColor(.white)
                        .menuTitle("Rectangle")
                }
                MenuLink {
                    MenuButton(title: "Circle", icons: .rightIcon("arrow.forward"))
                } content: {
                    VStack {
                        Circle()
                            .frame(width: 50, height: 50)
                            .foregroundColor(.white)
                            .menuTitle("Circle")
                        MenuLink {
                            MenuButton(title: "Ellipse", icons: .rightIcon("arrow.forward"))
                        } content: {
                            Ellipse()
                                .frame(width: 100, height: 50)
                                .foregroundColor(.white)
                                .menuTitle("Ellipse")
                        }

                    }
                    .menuTitle("Circle")
                }
            }
            .menuTitle("Main")
        }
    }
}
