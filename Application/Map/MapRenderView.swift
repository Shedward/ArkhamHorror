//
//  MapRenderView.swift
//  Arkham Horror (macOS)
//
//  Created by Vladislav Maltsev on 16.01.2022.
//

import SwiftUI
import ArkhamHorror

struct MapRenderView: View {
	let map: Map

    var body: some View {
		Canvas { context, size in
			let geometry = self.scalableGeometry(for: size, fitting: map.layout)
			map.layout.neighboarhoods.forEach { neighborhood in
				self.drawNeighborhood(neighborhood, withGeometry: geometry, in: context)
			}
		}
    }

	private func scalableGeometry(for size: CGSize, fitting layout: MapLayout) -> MapGeometry {
		MapGeometry(hexagonSize: 50, spacing: 25)
	}

	private func drawNeighborhood(
		_ neighborhood: MapLayout.Neighboarhood,
		withGeometry geometry: MapGeometry,
		in context: GraphicsContext
	) {
		let hexagon = geometry.hexagon(at: .init(x: neighborhood.position.x, y: neighborhood.position.y))
		let path = Path { path in
			path.move(to: hexagon.point(at: .v0).toCGPoint())
			for point in hexagon.allPoints {
				path.addLine(to: point.toCGPoint())
			}
			path.addLine(to: hexagon.point(at: .v0).toCGPoint())
		}
		context.fill(
			path,
			with: .color(regionTypeColor(for: neighborhood.typeId))
		)
	}

	private func regionTypeColor(for regionId: MapRegionType.Id) -> Color {
		let hue256 = regionId.rawValue.hash % 256
		let hueDouble = Double(hue256) / 256
		return Color(hue: hueDouble, saturation: 0.8, brightness: 0.8)
	}
}
