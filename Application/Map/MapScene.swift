//
//  MapScene.swift
//  Arkham Horror (macOS)
//
//  Created by Vladislav Maltsev on 01.08.2022.
//

import SceneKit
import SwiftUI

import Common
import Map

struct MapScene: View {
    let map: Map
    let mapGeometry = MapGeometry(hexagonSize: 1, spacing: 1)

    private var scene = SCNScene(named: "SceeneAssets.scnassets/Gameboard.scn")!
    private let gameboardNode = SCNNode()
    private let playerNode = SCNNode()

    var body: some View {
        SceneView(scene: scene)
            .onAppear(perform: configureScene)
    }

    public init(map: Map) {
        self.map = map
    }

    private func configureScene() {
        scene.rootNode.addChildNode(gameboardNode)
        configureCamera()
        configureLighting()
        configurePlayerNode()
        configureGameboard()
    }

    private func configureCamera() {
        let camera = SCNCamera()
        camera.usesOrthographicProjection = true
        camera.orthographicScale = 4
        camera.fieldOfView = 20

        let node = SCNNode()
        node.camera = camera
        node.position = pointOfView()

        scene.rootNode.addChildNode(node)
    }

    private func configureLighting() {
        scene.background.contents = UColor.white
        let light = createLight(
            type: .ambient,
            color: .white,
            intencity: 500,
            castShadows: false
        )
        light.position = .origin
        scene.rootNode.addChildNode(light)

        let light1 = createLight(
            type: .omni,
            color: .systemPink,
            intencity: 500,
            castShadows: true
        )
        light1.position = pointOfView().movedBy(dx: -5, dz: 5)
        scene.rootNode.addChildNode(light1)

        let light2 = createLight(
            type: .omni,
            color: .systemMint,
            intencity: 500,
            castShadows: true
        )
        light2.position = pointOfView().movedBy(dx: 5, dz: 5)
        scene.rootNode.addChildNode(light2)

        let light3 = createLight(
            type: .omni,
            color: .systemTeal,
            intencity: 500,
            castShadows: true
        )
        light3.position = pointOfView().movedBy(dy: 5, dz: 5)
        scene.rootNode.addChildNode(light3)
    }

    private func createLight(
        type: SCNLight.LightType,
        color: UColor,
        intencity: CGFloat = 1000,
        castShadows: Bool
    ) -> SCNNode {
        let light = SCNLight()
        light.color = color
        light.type = type
        light.intensity = intencity
        light.castsShadow = castShadows

        let node = SCNNode()
        node.light = light
        return node
    }

    private func configurePlayerNode() {
        let geometry = SCNCapsule(capRadius: 0.125, height: 0.5)
        geometry.materials = [regionMaterial()]

        playerNode.geometry = geometry
        playerNode.orientation = .init(axis: .xAxis, radians: .pi2)
        playerNode.position.z = regionHeight() + 0.25
        gameboardNode.addChildNode(playerNode)
        startWandering(node: playerNode)
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

    private func pointOfView() -> SCNVector3 {
        let boardSize = self.boardSize()
        return .init(boardSize.width / 2, boardSize.height / 2, boardSize.maxDimention * 3.0)
    }

    private func createNeighbourhoodNode(for neighboarhood: MapLayout.Neighboarhood) -> SCNNode {
        let hexagon = mapGeometry.hexagon()
        let regions = neighboarhood.regions.compactMap { regionId -> MapGeometry.Region? in
            guard let edge = neighboarhood.edge(for: regionId) else { return nil }
            let region = hexagon.region(at: edge)
            return region
        }

        let node = SCNNode()
        for region in regions {
            let regionNode = createRegionNode(for: region, height: regionHeight())
            node.addChildNode(regionNode)
        }

        let nodePosition = mapGeometry.origin(at: neighboarhood.position.toHexagonPosition())
        node.position = .init(nodePosition.x, nodePosition.y, regionHeight() / 2)
        return node
    }

    private func createStreetNode(for street: MapLayout.Street) -> SCNNode {
        let bridge = mapGeometry.bridge(
            from: street.from.position.toHexagonPosition(),
            to: street.to.position.toHexagonPosition(),
            fromEdge: street.from.edge
        )

        let region = bridge.region()
        let node = createRegionNode(for: region, height: regionHeight() / 2)
        node.position.z = UFloat(regionHeight() / 2)
        return node
    }

    private func createRegionNode(for region: MapGeometry.Region, height: CGFloat) -> SCNNode {
        let bezierPath = UBezierPath(points: region.border)

        let regionShape = SCNShape(path: bezierPath, extrusionDepth: height)
        regionShape.chamferRadius = regionHeight() / 10
        regionShape.chamferMode = .front
        regionShape.chamferProfile = UBezierPath(lineFrom: .init(x: 0, y: 1), to: .init(x: 1, y: 0))
        regionShape.materials = [regionMaterial()]

        let node = SCNNode(geometry: regionShape)
        return node
    }

    private func regionMaterial() -> SCNMaterial {
        let material = SCNMaterial()
        material.lightingModel = .blinn
        material.diffuse.contents = UColor(white: 0.85, alpha: 1.0)
        return material
    }

    private func regionHeight() -> CGFloat {
        return 0.2
    }

    private func startWandering(node: SCNNode) {
        class WanderingState {
            var currentRegionId: Region.Id = "arkham_advertiser"
        }

        let wanderingState = WanderingState()

        let wanderAction = SCNAction.run { [map, mapGeometry] node in
            guard let nextRegionId = map.neighbors(for: wanderingState.currentRegionId).randomElement() else { return }
            guard let geometryRegion = map.geometryRegion(by: nextRegionId, geometry: mapGeometry) else { return }

            SCNTransaction.begin()
            SCNTransaction.animationDuration = 0.5
            node.position.xy = geometryRegion.center.toUPoint()
            SCNTransaction.commit()

            wanderingState.currentRegionId = nextRegionId
        }

        let wanderingForever = SCNAction.repeatForever(.sequence([wanderAction, .wait(duration: 1)]))

        node.runAction(wanderingForever)
    }
}
