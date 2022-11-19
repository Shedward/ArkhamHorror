//
//  MapView.swift
//  Arkham Horror
//
//  Created by Vladislav Maltsev on 16.01.2022.
//

import SwiftUI
import Map

struct MapView: View {
	enum ViewState {
		case empty
		case failed(Error)
		case loaded(Map)
	}

	@State
	private var state: ViewState = .empty

	@Environment(\.colorScheme)
	var colorScheme

    var body: some View {
		ZStack {
			switch state {
			case .empty:
				Text("Drop map here")
			case .failed(let error):
				Text(String(describing: error))
					.foregroundColor(.red)
			case .loaded(let map):
                MapScene(map: map)
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
        MapView()
    }
}
