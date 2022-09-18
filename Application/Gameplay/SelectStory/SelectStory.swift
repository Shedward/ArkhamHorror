//
//  SelectStory.swift
//  Arkham Horror (macOS)
//
//  Created by Vladislav Maltsev on 18.09.2022.
//

import SwiftUI
import Prelude

struct SelectStoryView: View {
    var body: some View {
        MenuPage(title: Localized.string("Select story")) {
            HStack {
                
            }
        }
    }
}

struct SelectStory_Previews: PreviewProvider {
    static var previews: some View {
        SelectStoryView()
    }
}
