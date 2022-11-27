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
                Text("Screen 0")
                    .font(.title)
                MenuLink {
                    Text("Go to A")
                        .underline()
                        .bold()
                } content: {
                    Text("Screen A")
                        .font(.title)
                }
                MenuLink {
                    Text("Go to B")
                        .underline()
                        .bold()
                } content: {
                    VStack {
                        Text("Screen B")
                            .font(.title)
                        MenuLink {
                            Text("Go to C")
                                .underline()
                                .bold()
                        } content: {
                            Text("Screen C")
                                .font(.title)
                        }

                    }
                }
            }
        }
        .frame(minWidth: 300, minHeight: 200)
        .padding()
    }
}
