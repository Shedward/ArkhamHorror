//
//  MenuButton.swift
//  Arkham Horror
//
//  Created by Vladislav Maltsev on 06.11.2022.
//

import SwiftUI
import DesignSystem

struct MenuButton: View {

    @Environment(\.design)
    var design: DesignSystem

    struct Icons {
        var leftIconName: String?
        var leftHighlightedIcondName: String?
        var rightIconName: String?
        var rightHighlightedIcondName: String?

        static let none = Icons()

        static let leftArrow = Icons(
            leftIconName: "arrowtriangle.forward",
            leftHighlightedIcondName: "arrowtriangle.forward.fill"
        )

        static let mainButton = Icons(
            leftIconName: "arrowtriangle.forward",
            leftHighlightedIcondName: "arrowtriangle.forward.fill",
            rightIconName: "arrowtriangle.backward",
            rightHighlightedIcondName: "arrowtriangle.backward.fill"
        )

        static func leftIcon(_ name: String) -> Icons {
            Icons(leftIconName: name)
        }

        static func rightIcon(_ name: String) -> Icons {
            Icons(rightIconName: name)
        }
    }

    var title: String
    var icons: Icons = .none
    var textKind: DesignSystem.TextKind = \.menu.h2

    @State
    private var isHovered: Bool = false

    var body: some View {
        HStack(alignment: .center) {
            let textStyle = design.text.by(textKind)
            let iconTextStyle = textStyle.withIconStyle(textStyle.iconStyle.smaller(by: 6))

            if let leftIcon = isHovered
                ? icons.leftHighlightedIcondName ?? icons.leftIconName
                : icons.leftIconName
            {
                Image(systemName: leftIcon, withStyle: iconTextStyle)?
                        .foregroundColor(Color(textStyle.color))
            }
            Text(title).styled(textStyle)
            if let rightIcon = isHovered
                ? icons.rightHighlightedIcondName ?? icons.rightIconName
                : icons.rightIconName
            {
                Image(systemName: rightIcon, withStyle: iconTextStyle)
                    .foregroundColor(Color(textStyle.color))
            }
        }
    }
}

struct MenuButton_Provider_Previews: PreviewProvider {
    static var previews: some View {
        ZStack {
            Rectangle()
                .foregroundColor(.init(DesignSystem.default.color.content.main))
            VStack {
                MenuButton(title: "Start", icons: .mainButton)
                MenuButton(title: "Back", icons: .leftIcon("arrow.backward"))
            }
        }
    }
}
