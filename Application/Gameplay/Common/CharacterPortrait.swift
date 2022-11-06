//
//  CharacterPortrait.swift
//  Arkham Horror
//
//  Created by Vladislav Maltsev on 06.11.2022.
//

import SwiftUI

struct PortraitArc: Shape {
    func path(in rect: CGRect) -> Path {
        Path { path in
            path.move(to: .init(x: rect.minX, y: rect.maxY))
            path.addLine(to: .init(x: rect.minX, y: rect.midY))
            path.addArc(
                center: .init(x: rect.midX, y: rect.midX),
                radius: 0.5 * rect.width,
                startAngle: .degrees(180),
                endAngle: .degrees(0),
                clockwise: false
            )
            path.addLine(to: .init(x: rect.maxX, y: rect.maxY))
            path.closeSubpath()
        }
    }
}

struct CharacterPortrait: View {
    static let width: CGFloat = 60
    static let height: CGFloat = 72

    var body: some View {
        PortraitArc()
            .cornerRadius(8)
            .foregroundColor(Color(.Design.Background.secondary))
            .frame(width: CharacterPortrait.width, height: CharacterPortrait.height)
    }
}

struct CharacterPortrait_Previews: PreviewProvider {
    static var previews: some View {
        CharacterPortrait()
            .padding()
    }
}
