//
//  MapDebugView.swift
//  Arkham Horror (macOS)
//
//  Created by Vladislav Maltsev on 16.01.2022.
//

import SwiftUI
import ArkhamHorror

struct MapDebugView: View {
	enum ViewState {
		case empty
		case failed(Error)
		case loaded(Map)
	}

	@State
	private var state: ViewState = .empty

    var body: some View {
		ZStack {
			switch state {
			case .empty:
				Text("Drop map here")
			case .failed(let error):
				Text(String(describing: error))
					.foregroundColor(.red)
			case .loaded(let map):
				MapRenderView(map: map)
			}
		}
		.frame(minWidth: 500, minHeight: 500)
		.onDrop(
			of: MapDropDelegate.supportedTypes,
			delegate: MapDropDelegate { result in
				switch result {
				case .success(let map):
					self.state = .loaded(map)
				case .failure(let error):
					self.state = .failed(error)
				}
			}
		)
    }
}

struct MapDebugView_Previews: PreviewProvider {
    static var previews: some View {
        MapDebugView()
    }
}
