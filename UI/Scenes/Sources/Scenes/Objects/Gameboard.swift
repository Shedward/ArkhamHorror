//
//  Gameboard.swift
//  
//
//  Created by Vladislav Maltsev on 26.02.2023.
//

import Map
import simd
import HSLuvSwift

public final class Gameboard: SceneObject {
    public let mapGeometry = MapGeometry(hexagonSize: 1, spacing: 0.5)
    public let map: Map
    public private(set) var regions: [MapRegion] = []
    public private(set) var neighboarhoods: [MapNegihbourhood] = []

    public init(map: Map) {
        self.map = map
        super.init()

        configureEnvironment()
        configureGameboard()
    }

    private func boardSize() -> Geometry.Size {
        let maxPosition = map.layout.maxPosition().toHexagonPosition()
        let size = mapGeometry.endPoint(for: maxPosition)
        return size.toSize()
    }

    private func pointOfView() -> vector_float3 {
        let boardSize = self.boardSize()
        return .init(boardSize.width / 2, boardSize.height / 2, boardSize.maxDimention * 3.0)
    }

    private func configureEnvironment() {
        let pointOfView = pointOfView()
        let camera = Camera(at: pointOfView, lookingAt: pointOfView.with(z: 0))
        addChild(camera)

        let ambientLight = Light(
            at: .zero,
            type: .ambient,
            color: .white
        )
        addChild(ambientLight)

        let redLight = Light(
            at: pointOfView.movedBy(dx: -5, dz: 5),
            type: .omni,
            color: .init(hue: 0, saturation: 100, lightness: 100, alpha: 1.0),
            castShadows: true
        )
        addChild(redLight)

        let greenLight = Light(
            at: pointOfView.movedBy(dx: 5, dz: 5),
            type: .omni,
            color: .init(hue: 120, saturation: 100, lightness: 80, alpha: 1.0),
            castShadows: true
        )
        addChild(greenLight)

        let blueLight = Light(
            at: pointOfView.movedBy(dy: 5, dz: -5),
            type: .omni,
            color: .init(hue: 240, saturation: 100, lightness: 80, alpha: 1.0),
            castShadows: true
        )
        addChild(blueLight)
    }

    private func configureGameboard() {
        let neighboardhoods = map.layout.neighboarhoods.map(createNeighbourhood)
        neighboardhoods.forEach(addChild)

        let streets = map.layout.streets.map(createStreetRegion)
        streets.forEach(addChild)

        self.neighboarhoods = neighboardhoods
        self.regions = streets + neighboardhoods.flatMap(\.regions)
    }

    private func createNeighbourhood(for neighboarhood: MapLayout.Neighboarhood) -> MapNegihbourhood {
        let regions = neighboarhood.regions.compactMap { regionId -> MapRegion? in
            let zeroHexagon = mapGeometry.hexagon()
            guard let edge = neighboarhood.edge(for: regionId) else { return nil }
            let region = zeroHexagon.region(at: edge)
            let mapRegion = MapRegion(
                id: regionId,
                title: regionId.rawValue,
                region: region
            )
            return mapRegion
        }
        let neighbourhood = MapNegihbourhood(
            regionTypeId: neighboarhood.typeId,
            hexagon: mapGeometry.hexagon(at: neighboarhood.position.toHexagonPosition()),
            regions: regions
        )
        return neighbourhood
    }

    private func createStreetRegion(for street: MapLayout.Street) -> MapRegion {
        let bridge = mapGeometry.bridge(
            from: street.from.position.toHexagonPosition(),
            to: street.to.position.toHexagonPosition(),
            fromEdge: street.from.edge
        )

        let region = bridge.region()
        let mapRegion = MapRegion(
            id: street.regionId,
            title: street.regionId.rawValue,
            region: region
        )
        return mapRegion
    }
}
