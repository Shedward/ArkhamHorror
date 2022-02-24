//
//  MapRenderView.swift
//  Arkham Horror (macOS)
//
//  Created by Vladislav Maltsev on 16.01.2022.
//

import SwiftUI
import Map
import Common

struct MapRenderView: View {
	struct ColorScheme {
		struct Style {
			let foregroundSaturation: Double
			let foregroundBrightness: Double
			let backgroundSaturation: Double
			let backgroundBrightness: Double
			let markerColor: Color

			static let light = Style(
				foregroundSaturation: 0.8,
				foregroundBrightness: 0.6,
				backgroundSaturation: 0.6,
				backgroundBrightness: 0.8,
				markerColor: .white
			)
			static let dark = Style(
				foregroundSaturation: 0.6,
				foregroundBrightness: 0.8,
				backgroundSaturation: 0.8,
				backgroundBrightness: 0.6,
				markerColor: .black
			)
		}

		struct ShapeColors {
			let backgroundColor: Color
			let borderColor: Color
		}

		let style: Style

		init(style: Style) {
			self.style = style
		}

		func shape<T: Hashable>(for hashable: T) -> ShapeColors {
			let hueInt = hashable.hashValue % 1024
			let hueDouble = Double(hueInt) / 1024
			let borderColor = Color(hue: hueDouble, saturation: style.foregroundSaturation, brightness: style.foregroundBrightness)
			let backgroundColor = Color(hue: hueDouble, saturation: style.backgroundBrightness, brightness: style.backgroundBrightness)
			return ShapeColors(backgroundColor: backgroundColor, borderColor: borderColor)
		}

		var regionMarkerColor: Color {
			style.markerColor
		}

		var graphEdgeColor: Color {
			style.markerColor.opacity(0.2)
		}
	}

	let colorScheme: ColorScheme
	let showRegions: Bool = true
	let showGraph: Bool = true
	let showRegionId: Bool = true
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

			if showGraph {
				drawEdges(withGeometry: geometry, in: context)
			}
		}
    }

	private func scalableGeometry(for size: CGSize, fitting layout: MapLayout) -> MapGeometry {
		let maxXPosition = layout.neighboarhoods.map { $0.position.x }.max() ?? 0
		let maxYPosition = layout.neighboarhoods.map { $0.position.y }.max() ?? 0

		return MapGeometry.scaledToFit(
			size: .init(cgSize: size),
			maxPosition: .init(x: maxXPosition, y: maxYPosition),
			relativeSpacing: 0.5
		)
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
		let shapeColors = colorScheme.shape(for: neighborhood.typeId)
		context.fill(path, with: .color(shapeColors.backgroundColor))
		context.stroke(path, with: .color(shapeColors.borderColor), lineWidth: 1)

		drawRegionBorders(
			for: hexagon,
			edges: neighborhood.borderEdges(),
			borderColor: shapeColors.borderColor,
			in: context
		)

		if showRegions {
			neighborhood.regions
				.compactMap { neighborhood.edge(for: $0).map { hexagon.region(at: $0) } }
				.forEach { drawRegionMarker($0, in: context) }
		}
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

		let shapeColors = colorScheme.shape(for: street.typeId)

		context.fill(path, with: .color(shapeColors.backgroundColor))
		context.stroke(path, with: .color(shapeColors.borderColor), lineWidth: 1)

		if showRegions {
			drawRegionMarker(bridge.region(), in: context)
		}
	}

	private func drawRegionMarker(
		_ region: MapGeometry.Region,
		in context: GraphicsContext
	) {
		let radius = 2.0
		let rect = CGRect(
			x: region.center.x - radius,
			y: region.center.y - radius,
			width: 2 * radius,
			height: 2 * radius
		)
		let path = Path(ellipseIn: rect)
		context.fill(path, with: .color(colorScheme.regionMarkerColor))
	}

	private func drawEdges(
		withGeometry mapGeometry: MapGeometry,
		in context: GraphicsContext
	) {
		struct RegionDescription {
			let regionId: Region.Id
			let center: Geometry.Point
		}

		var regionDescriptions: [RegionDescription] = []

		map.layout.streets.forEach { street in
			let streetRegion = mapGeometry
				.bridge(
					from: street.from.position.toHexagonPosition(),
					to: street.to.position.toHexagonPosition(),
					fromEdge: street.from.edge
				)
				.region()
			regionDescriptions.append(.init(regionId: street.regionId, center: streetRegion.center))
		}

		map.layout.neighboarhoods.forEach { neighboarhood in
			let hexagon = mapGeometry.hexagon(at: neighboarhood.position.toHexagonPosition())
			neighboarhood.regions.forEach { regionId in
				if let regionEdge = neighboarhood.edge(for: regionId) {
					let region = hexagon.region(at: regionEdge)
					regionDescriptions.append(.init(regionId: regionId, center: region.center))
				}
			}
		}

		for startIndex in regionDescriptions.indices {
			for endIndex in regionDescriptions.indices {
				let startRegion = regionDescriptions[startIndex]
				let endRegion = regionDescriptions[endIndex]

				if map.isNeighborRegions(startRegion.regionId, endRegion.regionId) {
					let line = Path { path in
						path.move(to: startRegion.center.toCGPoint())
						path.addLine(to: endRegion.center.toCGPoint())
					}

					context.stroke(line, with: .color(colorScheme.graphEdgeColor))
				}
			}
		}
	}
}
