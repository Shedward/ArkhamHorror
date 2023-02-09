//
//  MapScene.swift
//  Arkham Horror
//
//  Created by Vladislav Maltsev on 01.08.2022.
//

import SceneKit
import SwiftUI

import Prelude
import Common
import Map
import DesignSystem

struct MapScene: View {
    let map: Map
    let mapGeometry = MapGeometry(hexagonSize: 1, spacing: 0.5)

    private var scene = SCNScene()
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
        configurePlayers()
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
        scene.background.contents = UColor(white: 0.10, alpha: 1)
        let light = createLight(
            type: .ambient,
            color: .white,
            castShadows: false
        )
        light.position = .origin
        scene.rootNode.addChildNode(light)

        let light1 = createLight(
            type: .omni,
            color: .init(hue: 0, saturation: 100, lightness: 80, alpha: 1.0),
            castShadows: true
        )
        light1.position = pointOfView().movedBy(dx: -5, dz: 5)
        scene.rootNode.addChildNode(light1)

        let light2 = createLight(
            type: .omni,
            color: .init(hue: 120, saturation: 100, lightness: 80, alpha: 1.0),
            castShadows: true
        )
        light2.position = pointOfView().movedBy(dx: 5, dz: 5)
        scene.rootNode.addChildNode(light2)

        let light3 = createLight(
            type: .omni,
            color: .init(hue: 240, saturation: 100, lightness: 80, alpha: 1.0),
            castShadows: true
        )
        light3.position = pointOfView().movedBy(dy: 5, dz: 5)
        scene.rootNode.addChildNode(light3)
    }

    private func createLight(
        type: SCNLight.LightType,
        color: UColor,
        intencity: CGFloat = 1000,
        temperature: CGFloat = 6500,
        castShadows: Bool
    ) -> SCNNode {
        let light = SCNLight()
        light.color = color
        light.type = type
        light.intensity = intencity
        light.castsShadow = castShadows
        light.temperature = temperature

        let node = SCNNode()
        node.light = light
        return node
    }

    private func configurePlayers() {
        createPlayerNode(color: UColor(rgb: 0xf2950e))
        createPlayerNode(color: UColor(rgb: 0x0dac98))
    }

    private func createPlayerNode(color: UColor) {
        let geometry = SCNPyramid(width: 0.125, height: 0.5, length: 0.25)

        geometry.materials = [regionMaterial(color: color)]

        let playerNode = with(SCNNode()) { node in
            node.light = with(SCNLight()) { light in
                light.type = .omni
                light.color = color
                light.intensity = 3000
                light.castsShadow = true
            }

            node.geometry = geometry
            node.orientation = .init(axis: .xAxis, radians: .pi2)
            node.position.z = regionHeight() + 0.05
        }
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
        let regions = neighboarhood.regions.compactMap { regionId -> (MapGeometry.Region, Region.ID)? in
            guard let edge = neighboarhood.edge(for: regionId) else { return nil }
            let region = hexagon.region(at: edge)
            return (region, regionId)
        }

        let node = SCNNode()
        for (region, regionId) in regions {
            let regionNode = createRegionNode(
                title: regionId.rawValue,
                region: region,
                color: UColor(white: 0.30, alpha: 1.0),
                contentColor: UColor(white: 0.15, alpha: 1.0),
                height: regionHeight()
            )
            node.addChildNode(regionNode)
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
        let node = createRegionNode(
            title: street.regionId.rawValue,
            region: region,
            color: UColor(white: 0.15, alpha: 1.0),
            contentColor: UColor(white: 0.30, alpha: 1.0),
            height: regionHeight() / 2
        )
        return node
    }

    private func createRegionNode(
        title: String?,
        region: MapGeometry.Region,
        color: UColor,
        contentColor: UColor,
        height: UFloat
    ) -> SCNNode {
        let bezierPath = UBezierPath(points: region.border)

        let regionShape = SCNShape(path: bezierPath, extrusionDepth: CGFloat(height))
        let champferRadius = regionHeight() / 5

        regionShape.chamferRadius = CGFloat(regionHeight() / 5)
        regionShape.chamferMode = .front
        regionShape.chamferProfile = UBezierPath(lineFrom: .init(x: 0, y: 1), to: .init(x: 1, y: 0))
        regionShape.materials = [regionMaterial(color: color)]
        let shapeNode = SCNNode(geometry: regionShape)

        let text = SCNText(string: title, extrusionDepth: 1)
        let fontSize: CGFloat = 12.0
        text.font = .init(name: "AmericanTypewriter", size: fontSize)
        text.materials = [regionMaterial(color: contentColor)]
        let textNode = SCNNode(geometry: text)
        textNode.position.xy = .init(x: champferRadius, y: champferRadius)
        textNode.scale = .uniformScale(1 / UFloat(fontSize * 10))

        let regionLegendNode = SCNNode()
        regionLegendNode.position.xy = region.axis.start.toUPoint()
        regionLegendNode.position.z = height / 2
        regionLegendNode.orientation = .init(axis: .zAxis, radians: Float(region.axis.angle))
        regionLegendNode.addChildNode(textNode)

        let containerNode = SCNNode()
        containerNode.addChildNode(shapeNode)
        containerNode.addChildNode(regionLegendNode)
        return containerNode
    }

    private func regionMaterial(color: UColor) -> SCNMaterial {
        let material = SCNMaterial()
        material.lightingModel = .blinn
        material.diffuse.contents = color
        return material
    }

    private func regionHeight() -> UFloat {
        return 0.2
    }

    private func startWandering(node: SCNNode) {
        class WanderingState {
            var currentRegionId: Region.ID = "arkham_advertiser"
        }

        let wanderingState = WanderingState()

        let wanderAction = SCNAction.run { [map, mapGeometry] node in
            guard let nextRegionId = map.neighbors(for: wanderingState.currentRegionId).randomElement() else { return }
            guard let geometryRegion = map.geometryRegion(by: nextRegionId, geometry: mapGeometry) else { return }

            SCNTransaction.begin()
            SCNTransaction.animationDuration = 0.75
            node.position.xy = geometryRegion.center.toUPoint()
            SCNTransaction.commit()

            wanderingState.currentRegionId = nextRegionId
        }

        let wanderingForever = SCNAction.repeatForever(.sequence([wanderAction, .wait(duration: 1.25)]))

        let rotation = SCNAction.repeatForever(.rotate(by: .pi2, around: .zAxis, duration: 1))
        node.runAction(wanderingForever)
        node.runAction(rotation)
    }
}
