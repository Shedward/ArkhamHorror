//
//  MapRenderView.swift
//  Arkham Horror (macOS)
//
//  Created by Vladislav Maltsev on 16.01.2022.
//

import SwiftUI
import ArkhamHorror

struct MapRenderView: View {
	private struct ShapeColors {
		let backgroundColor: Color
		let borderColor: Color

		init<T: Hashable>(hashable: T) {
			let hue256 = hashable.hashValue % 256
			let hueDouble = Double(hue256) / 256
			backgroundColor = Color(hue: hueDouble, saturation: 0.8, brightness: 0.6)
			borderColor = Color(hue: hueDouble, saturation: 0.6, brightness: 0.8)
		}
	}

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
		MapGeometry(hexagonSize: 75, spacing: 25)
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
		let shapeColors = ShapeColors(hashable: neighborhood.typeId)
		context.fill(path, with: .color(shapeColors.backgroundColor))
		context.stroke(path, with: .color(shapeColors.borderColor), lineWidth: 1)

		drawRegionBorders(
			for: hexagon,
			orientation: neighborhood.regionOrientation,
			borderColor: shapeColors.borderColor,
			in: context
		)
	}

	private func drawRegionBorders(
		for hexagon: MapGeometry.Hexagon,
		orientation: MapLayout.RegionOrientation,
		borderColor: Color,
		in context: GraphicsContext
	) {
		let center = hexagon.center.toCGPoint()
		let path = Path { path in
			path.move(to: center)
			func drawBorderToEdge(_ edge: MapGeometry.Hexagon.Edge) {
				path.addLine(to: hexagon.line(at: edge).middle.toCGPoint())
				path.addLine(to: center)
			}

			switch orientation {
			case .clockwise:
				drawBorderToEdge(.e1)
				drawBorderToEdge(.e3)
				drawBorderToEdge(.e5)
			case .counterclockwise:
				drawBorderToEdge(.e0)
				drawBorderToEdge(.e2)
				drawBorderToEdge(.e4)
			}
		}

		context.stroke(path, with: .color(borderColor), lineWidth: 1)
	}
}
