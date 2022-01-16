//
//  MapDebugView.swift
//  Arkham Horror (macOS)
//
//  Created by Vladislav Maltsev on 16.01.2022.
//

import SwiftUI

struct MapDebugView: View {
	@State
	private var text: String = "Drop map here"

    var body: some View {
		Text(text)
			.frame(minWidth: 500, minHeight: 500)
			.onDrop(
				of: MapDropDelegate.supportedTypes,
				delegate: MapDropDelegate { result in
					self.text = String(describing: result)
				}
			)
    }
}

struct MapDebugView_Previews: PreviewProvider {
    static var previews: some View {
        MapDebugView()
    }
}
