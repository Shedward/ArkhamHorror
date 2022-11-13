//
//  MenuButton.swift
//  Arkham Horror
//
//  Created by Vladislav Maltsev on 06.11.2022.
//

import SwiftUI

struct MenuButton: View {
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
    var textStyle: TextStyle = .Design.Menu.h2
    var onTap: (() -> Void)?

    @State
    private var isHovered: Bool = false

    var body: some View {
        HStack(alignment: .center) {
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
        .onHover { isHovered in
            self.isHovered = isHovered
        }
        .onTapGesture {
            onTap?()
        }
    }
}

struct MenuButton_Provider_Previews: PreviewProvider {
    static var previews: some View {
        ZStack {
            Rectangle()
                .foregroundColor(.init(.Design.Background.main))
            VStack {
                MenuButton(title: "Start", icons: .mainButton)
                MenuButton(title: "Back", icons: .leftIcon("arrow.backward"))
            }
        }
    }
}
