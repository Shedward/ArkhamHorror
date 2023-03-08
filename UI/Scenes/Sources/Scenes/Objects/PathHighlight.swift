//
//  PathHighlight.swift
//  
//
//  Created by Vladislav Maltsev on 05.03.2023.
//

import Foundation
import DesignSystem
import simd
import SceneKit

public final class PathHightlight: SceneObject {
    private let points: [vector_float2]
    private let elevation: Float
    private let color: UColor

    private var lineNodes: [SCNNode] = []

    public init(points: [vector_float2], elevation: Float, color: UColor) {
        self.points = points
        self.elevation = elevation
        self.color = color

        super.init()

        buildLines()
    }

    private func buildLines() {
        lineNodes.forEach { $0.removeFromParentNode() }
        lineNodes = points.indices.dropLast(1).compactMap { index in
            let nextIndex = index + 1
            guard points.indices.contains(nextIndex) else { return nil }

            let lineNode = createLineNode(from: points[index], to: points[nextIndex])
            node.addChildNode(lineNode)
            return lineNode
        }
    }

    private func createLineNode(from startPoint: vector_float2, to endPoint: vector_float2) -> SCNNode {
        let vector = startPoint - endPoint
        let distance = distance(.zero, vector)
        let midPoint = (startPoint + endPoint) / 2.0

        let lineGeometry = SCNCylinder()
        lineGeometry.radius = 0.01
        lineGeometry.height = CGFloat(distance)
        lineGeometry.radialSegmentCount = 3
        lineGeometry.heightSegmentCount = 1
        lineGeometry.firstMaterial?.diffuse.contents = color

        let lineNode = SCNNode(geometry: lineGeometry)
        lineNode.position = vec3(at: midPoint)
        lineNode.look(at: vec3(at: endPoint), up: .yAxis, localFront: lineNode.worldUp)
        return lineNode
    }

    private func vec3(at point: vector_float2) -> SCNVector3 {
        SCNVector3(point.x, point.y, elevation)
    }
}
