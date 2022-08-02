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
    let mapGeometry = MapGeometry(hexagonSize: 1, spacing: 0.5)

    private var scene = SCNScene(named: "SceeneAssets.scnassets/Gameboard.scn")!
    private let gameboardNode = SCNNode()

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
        configureGameboard()
    }

    private func configureCamera() {
        let camera = SCNCamera()
        camera.fieldOfView = 20

        let node = SCNNode()
        node.camera = camera
        node.position = pointOfView()

        scene.rootNode.addChildNode(node)
    }

    private func configureLighting() {
        scene.background.contents = UIColor.white

        let light1 = createLight(type: .omni, color: .systemGreen, castShadows: true)
        light1.position = pointOfView().movedBy(dx: -5)
        scene.rootNode.addChildNode(light1)

        let light2 = createLight(type: .omni, color: .systemPink, castShadows: true)
        light2.position = pointOfView().movedBy(dx: 5)
        scene.rootNode.addChildNode(light2)

        let light3 = createLight(type: .omni, color: .systemBlue, castShadows: true)
        light3.position = pointOfView().movedBy(dy: 5)
        scene.rootNode.addChildNode(light3)

        let light4 = createLight(type: .ambient, color: .white, castShadows: false)
        light4.position = pointOfView()
        scene.rootNode.addChildNode(light4)
    }

    private func createLight(type: SCNLight.LightType, color: UIColor, castShadows: Bool) -> SCNNode {
        let light = SCNLight()
        light.color = color
        light.type = type
        light.intensity = 500
        light.castsShadow = castShadows

        let node = SCNNode()
        node.light = light
        return node
    }

    private func configureGameboard() {
        map.layout.neighboarhoods.forEach { neighboarhood in
            let neighboarhoodNode = createNeighbourhoodNode(for: neighboarhood)
            gameboardNode.addChildNode(neighboarhoodNode)
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
            let regionNode = createRegionNode(for: region)
            node.addChildNode(regionNode)
        }
        let nodePosition = mapGeometry.origin(at: neighboarhood.position.toHexagonPosition())
        node.position = .init(nodePosition.x, nodePosition.y, 0.1)
        return node
    }

    private func createRegionNode(for region: MapGeometry.Region) -> SCNNode {
        let bezierPath = UBezierPath(points: region.border)

        let regionShape = SCNShape(path: bezierPath, extrusionDepth: 0.2)
        regionShape.chamferRadius = 0.02
        regionShape.chamferMode = .front
        regionShape.chamferProfile = UBezierPath(lineFrom: .init(x: 0, y: 1), to: .init(x: 1, y: 0))

        let material = SCNMaterial()
        regionShape.materials = [material]

        let node = SCNNode(geometry: regionShape)
        return node
    }
}
