//
//  UnderConstructionView.swift
//  Arkham Horror
//
//  Created by Vladislav Maltsev on 12.11.2022.
//

import SwiftUI
import Prelude

struct UnderConstructionView: View {
    @Environment(\.design)
    var design: DesignSystem

    let textKind: DesignSystem.TextKind

    var body: some View {
        let textStyle = design.text.by(textKind)
        VStack {
            Image(systemName: "hammer", withStyle: textStyle)?
                .foregroundColor(Color(textStyle.color))
            Text(Localized.string("Under construction"))
                .styled(textStyle)
        }
        .padding()
        .border(Color(textStyle.color))
        .frame(maxWidth: .infinity, maxHeight: .infinity)
    }
}

struct UnderConstructionView_Previews: PreviewProvider {
    static var previews: some View {
        UnderConstructionView(textKind: \.content.debug)
    }
}
