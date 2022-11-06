//
//  MenuButton.swift
//  Arkham Horror
//
//  Created by Vladislav Maltsev on 06.11.2022.
//

import SwiftUI

struct MenuButton: View {
    struct HighlitingStyle {
        let leftIconName: String?
        let leftHighlightedIcondName: String?
        let rightIconName: String?
        let rightHighlightedIcondName: String?

        static let none = HighlitingStyle(
            leftIconName: nil,
            leftHighlightedIcondName: nil,
            rightIconName: nil,
            rightHighlightedIcondName: nil
        )

        static let left = HighlitingStyle(
            leftIconName: "arrowtriangle.forward",
            leftHighlightedIcondName: "arrowtriangle.forward.fill",
            rightIconName: nil,
            rightHighlightedIcondName: nil
        )

        static let mainButton = HighlitingStyle(
            leftIconName: "arrowtriangle.forward",
            leftHighlightedIcondName: "arrowtriangle.forward.fill",
            rightIconName: "arrowtriangle.backward",
            rightHighlightedIcondName: "arrowtriangle.backward.fill"
        )
    }

    var iconName: String?
    var title: String
    var highlightingStyle: HighlitingStyle = .none
    var textStyle: TextStyle = .Design.menuSubtitle
    var onTap: (() -> Void)?

    @State
    private var isHovered: Bool = false

    var body: some View {
        HStack(alignment: .center) {
            let iconTextStyle = textStyle.withIconStyle(textStyle.iconStyle.smaller(by: 6))

            if let leftIcon = isHovered
                ? highlightingStyle.leftHighlightedIcondName
                : highlightingStyle.leftIconName
            {
                Image(systemName: leftIcon, withStyle: iconTextStyle)
            }
            if let iconName {
                Image(systemName: iconName, withStyle: iconTextStyle)
            }
            Text(title).styled(textStyle)
            if let rightIcon = isHovered
                ? highlightingStyle.rightHighlightedIcondName
                : highlightingStyle.rightIconName
            {
                Image(systemName: rightIcon, withStyle: iconTextStyle)
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
                MenuButton(title: "Start",highlightingStyle: .mainButton)
                MenuButton(iconName: "arrow.backward", title: "Back")
            }
        }
    }
}
