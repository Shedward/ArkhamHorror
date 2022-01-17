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
			borderColor = Color(hue: hueDouble, saturation: 0.8, brightness: 0.6)
			backgroundColor = Color(hue: hueDouble, saturation: 0.6, brightness: 0.8)
		}
	}

	let map: Map

    var body: some View {
		Canvas { context, size in
			let geometry = self.scalableGeometry(for: size, fitting: map.layout)
			map.layout.neighboarhoods.forEach { neighborhood in
				self.drawNeighborhood(neighborhood, withGeometry: geometry, in: context)
			}
			map.layout.streets.forEach { street in
				self.drawStreet(street, withGeometry: geometry, in: context)
			}
		}
    }

	private func scalableGeometry(for size: CGSize, fitting layout: MapLayout) -> MapGeometry {
		MapGeometry(hexagonSize: 50, spacing: 30)
	}

	private func drawNeighborhood(
		_ neighborhood: MapLayout.Neighboarhood,
		withGeometry geometry: MapGeometry,
		in context: GraphicsContext
	) {
		let hexagon = geometry.hexagon(at: neighborhood.position.toHexagonPosition())
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
			edges: neighborhood.borderEdges(),
			borderColor: shapeColors.borderColor,
			in: context
		)

		neighborhood.regions
			.compactMap { neighborhood.edge(for: $0).map { hexagon.region(at: $0) } }
			.forEach { drawRegionMarker($0, in: context) }
	}

	private func drawRegionBorders(
		for hexagon: MapGeometry.Hexagon,
		edges: [MapGeometry.Hexagon.Edge],
		borderColor: Color,
		in context: GraphicsContext
	) {
		let center = hexagon.center.toCGPoint()
		let path = Path { path in
			path.move(to: center)
			edges.forEach { edge in
				path.addLine(to: hexagon.line(at: edge).middle.toCGPoint())
				path.addLine(to: center)
			}
		}

		context.stroke(path, with: .color(borderColor), lineWidth: 1)
	}

	private func drawStreet(
		_ street: MapLayout.Street,
		withGeometry geometry: MapGeometry,
		in context: GraphicsContext
	) {
		let bridge = geometry.bridge(
			from: street.from.position.toHexagonPosition(),
			to: street.to.position.toHexagonPosition(),
			fromEdge: street.from.edge
		)

		let path = Path { path in
			path.move(to: bridge.startLine.start.toCGPoint())
			path.addLine(to: bridge.startLine.end.toCGPoint())
			path.addLine(to: bridge.endLine.start.toCGPoint())
			path.addLine(to: bridge.endLine.end.toCGPoint())
			path.addLine(to: bridge.startLine.start.toCGPoint())
		}

		let shapeColors = ShapeColors(hashable: street.typeId)

		context.fill(path, with: .color(shapeColors.backgroundColor))
		context.stroke(path, with: .color(shapeColors.borderColor), lineWidth: 1)

		drawRegionMarker(bridge.region(), in: context)
	}

	private func drawRegionMarker(
		_ region: MapGeometry.Region,
		in context: GraphicsContext
	) {
		let radius = region.width / 3
		let rect = CGRect(
			x: region.center.x - radius,
			y: region.center.y - radius,
			width: 2 * radius,
			height: 2 * radius
		)
		let path = Path(ellipseIn: rect)
		context.fill(path, with: .color(white: 1.0, opacity: 0.5))
	}
}