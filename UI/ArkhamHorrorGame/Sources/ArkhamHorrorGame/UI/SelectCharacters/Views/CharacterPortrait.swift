//
//  CharacterPortrait.swift
//  Arkham Horror
//
//  Created by Vladislav Maltsev on 06.11.2022.
//

import SwiftUI
import DesignSystem

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
    enum Size {
        case small
        case big

        var scale: CGFloat {
            switch self {
            case .small:
                return 1.0
            case .big:
                return 2.0
            }
        }
    }

    static func width(for size: Size) -> CGFloat {
        60 * size.scale
    }
    static func height(for size: Size) -> CGFloat {
        72 * size.scale
    }

    @Environment(\.design)
    var design: DesignSystem

    var size: Size

    var body: some View {
        PortraitArc()
            .cornerRadius(8)
            .foregroundColor(design.color.background.secondary)
            .frame(
                width: CharacterPortrait.width(for: size),
                height: CharacterPortrait.height(for: size)
            )
    }
}

struct CharacterPortrait_Previews: PreviewProvider {
    static var previews: some View {
        CharacterPortrait(size: .big)
            .padding()
    }
}
