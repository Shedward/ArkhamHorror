import SpriteKit

extension SKNode {
    func containsHit(at point: CGPoint, in scene: SKScene) -> Bool {
        let hit = scene.atPoint(point)
        return hit === self || hit.inParentHierarchy(self)
    }
}
