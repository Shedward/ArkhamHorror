//
//  MapScene.swift
//  
//
//  Created by Vladislav Maltsev on 10.02.2023.
//

import SceneKit
import SpriteKit
import Prelude
import Common
import Map
import DesignSystem
import HSLuvSwift

final class MapScene: SCNScene {
    let map: Map
    let mapGeometry = MapGeometry(hexagonSize: 1, spacing: 0.5)

    let gameboardNode = SCNNode()

    public init(map: Map) {
        self.map = map
        super.init()
        configureScene()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func configureScene() {
        rootNode.addChildNode(gameboardNode)
        configureEnvironment()
        configureGameboard()
        configurePlayers()
    }

    private func configureEnvironment() {
        let pointOfView = pointOfView()
        let camera = Camera(at: pointOfView, lookingAt: gameboardNode.simdPosition)
        rootNode.addChildNode(camera.node)

        background.contents = UColor(white: 0.10, alpha: 1)
        let ambientLight = Light(
            at: .zero,
            type: .ambient,
            color: .white
        )
        rootNode.addChildNode(ambientLight.node)

        let redLight = Light(
            at: pointOfView.movedBy(dx: -5, dz: 5),
            type: .omni,
            color: .init(hue: 0, saturation: 100, lightness: 100, alpha: 1.0),
            castShadows: true
        )
        rootNode.addChildNode(redLight.node)

        let greenLight = Light(
            at: pointOfView.movedBy(dx: 5, dz: 5),
            type: .omni,
            color: .init(hue: 120, saturation: 100, lightness: 80, alpha: 1.0),
            castShadows: true
        )
        rootNode.addChildNode(greenLight.node)

        let blueLight = Light(
            at: pointOfView.movedBy(dy: 5, dz: -5),
            type: .omni,
            color: .init(hue: 240, saturation: 100, lightness: 80, alpha: 1.0),
            castShadows: true
        )
        rootNode.addChildNode(blueLight.node)
    }

    private func configurePlayers() {
        let player1 = Player(color: UColor(rgb: 0xf2950e))
        gameboardNode.addChildNode(player1.node)
        let player2 = Player(color: UColor(rgb: 0x0dac98))
        gameboardNode.addChildNode(player2.node)
    }

    private func configureGameboard() {
        map.layout.neighboarhoods.forEach { neighboarhood in
            let neighboarhoodNode = createNeighbourhoodNode(for: neighboarhood)
            gameboardNode.addChildNode(neighboarhoodNode)
        }

        map.layout.streets.forEach { street in
            let streetNode = createStreetNode(for: street)
            gameboardNode.addChildNode(streetNode)
        }
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

    private func createNeighbourhoodNode(for neighboarhood: MapLayout.Neighboarhood) -> SCNNode {
        let hexagon = mapGeometry.hexagon()
        let regions = neighboarhood.regions.compactMap { regionId -> (MapGeometry.Region, Region.ID)? in
            guard let edge = neighboarhood.edge(for: regionId) else { return nil }
            let region = hexagon.region(at: edge)
            return (region, regionId)
        }

        let node = SCNNode()
        for (region, regionId) in regions {
            let mapRegion = MapRegion(title: regionId.rawValue, region: region)
            node.addChildNode(mapRegion.node)
        }

        let nodePosition = mapGeometry.origin(at: neighboarhood.position.toHexagonPosition())
        node.position = .init(nodePosition.x, nodePosition.y, 0)
        return node
    }

    private func createStreetNode(for street: MapLayout.Street) -> SCNNode {
        let bridge = mapGeometry.bridge(
            from: street.from.position.toHexagonPosition(),
            to: street.to.position.toHexagonPosition(),
            fromEdge: street.from.edge
        )

        let region = bridge.region()
        let mapRegion = MapRegion(
            title: street.regionId.rawValue,
            region: region
        )
        return mapRegion.node
    }
}

public extension Scenes {
    static func mapScene(_ map: Map) -> SCNScene {
        let scene = MapScene(map: map)
        return scene
    }
}
