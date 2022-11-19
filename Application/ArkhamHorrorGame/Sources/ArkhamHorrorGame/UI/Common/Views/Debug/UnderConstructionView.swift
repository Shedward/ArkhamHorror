//
//  UnderConstructionView.swift
//  Arkham Horror
//
//  Created by Vladislav Maltsev on 12.11.2022.
//

import SwiftUI
import Prelude

struct UnderConstructionView: View {
    let textStyle: TextStyle

    var body: some View {
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
        UnderConstructionView(textStyle: .Design.debug)
    }
}
