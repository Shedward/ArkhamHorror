//
//  MapRegion.swift
//  
//
//  Created by Vladislav Maltsev on 16.02.2023.
//

import SceneKit
import Common
import Map
import DesignSystem

public final class MapRegion: SceneObject {
    static let height: Float = 0.2

    static func material(color: UColor) -> SCNMaterial {
        let material = SCNMaterial()
        material.lightingModel = .blinn
        material.diffuse.contents = color
        return material
    }

    public let id: Region.ID

    public init(id: Region.ID, title: String, region: MapGeometry.Region) {
        self.id = id
        let color = UColor(white: 0.15, alpha: 1.0)
        let contentColor = UColor(white: 0.30, alpha: 1.0)
        let height = MapRegion.height / 2.0

        let bezierPath = UBezierPath(points: region.border)

        let regionShape = SCNShape(path: bezierPath, extrusionDepth: CGFloat(height))
        let champferRadius = MapRegion.height / 5

        regionShape.chamferRadius = CGFloat(MapRegion.height / 5)
        regionShape.chamferMode = .front
        regionShape.chamferProfile = UBezierPath(lineFrom: .init(x: 0, y: 1), to: .init(x: 1, y: 0))
        regionShape.materials = [MapRegion.material(color: color)]
        let shapeNode = SCNNode(geometry: regionShape)

        let text = SCNText(string: title, extrusionDepth: 1)
        let fontSize: CGFloat = 12.0
        text.font = .init(name: "AmericanTypewriter", size: fontSize)
        text.materials = [MapRegion.material(color: contentColor)]
        let textNode = SCNNode(geometry: text)
        textNode.simdPosition.x = champferRadius
        textNode.simdPosition.y = champferRadius
        textNode.simdScale = .init(uniform: 1.0 / Float(fontSize * 10.0))

        let regionLegendNode = SCNNode()
        regionLegendNode.simdPosition.x = region.axis.start.x
        regionLegendNode.simdPosition.y = region.axis.start.y
        regionLegendNode.simdPosition.z = height / 2.0
        regionLegendNode.orientation = .init(axis: .zAxis, radians: Float(region.axis.angle))
        regionLegendNode.addChildNode(textNode)

        let containerNode = SCNNode()
        containerNode.addChildNode(shapeNode)
        containerNode.addChildNode(regionLegendNode)
        super.init(node: containerNode)
    }
}
