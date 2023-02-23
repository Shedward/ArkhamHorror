//
//  GameEpisode.swift
//  
//
//  Created by Vladislav Maltsev on 18.02.2023.
//

import SpriteKit
import SceneKit

import Prelude
import HUD
import Scenes

@MainActor
class BaseGameEpisode {
    private var presentedViews: [PresentedView] = []
    private var presentedObjects: [PresentedObject] = []
    private let logger = Logger()

    private var parentEpisode: BaseGameEpisode?
    private var childEpisodes: [BaseGameEpisode] = []

    private var scene: GameScene?
    let episodes: Episodes

    var defaultOverlayTransition: AnyNodeTransition<SKNode> =
        NonSymmericalTransition(
            enter: FadeSpriteTransition(),
            leave: BasicSpriteTransition()
        ).asAny()

    var overlaySize: CGSize {
        scene?.overlay.size ?? .zero
    }

    // MARK: - Lifecycle

    init(episodes: Episodes) {
        self.episodes = episodes
    }

    func didEnd() {
    }

    func willBegin() {
    }

    func prepare() {
        willBegin()
    }

    func finalize() {
        removeAll()
        didEnd()
    }

    // MARK: - Subepisodes

    func start(in scene: GameScene) {
        self.scene = scene
        prepare()
    }

    func startChildEpisode(_ childEpisode: BaseGameEpisode) {
        childEpisodes.append(childEpisode)
        childEpisode.scene = scene
        childEpisode.prepare()
    }

    func end() {
        finalize()
        parentEpisode?.childEpisodes.removeAll { $0 === self }
    }

    // MARK: - View and object managment

    func layout() {
        presentedViews.forEach { $0.view.layout() }
    }

    private func removeAll() {
        for presentedObject in presentedObjects {
            removeObject(presentedObject.object, transition: presentedObject.transition)
        }
        for presentedView in presentedViews {
            removeView(presentedView.view, transition: presentedView.transition)
        }
    }

    func addView<Transition: NodeTransition>(
        _ view: View,
        transition: Transition
    ) where Transition.Node == SKNode {
        guard let scene else {
            logger.error("""
            Tried to add view \(view) to episode \(self) without scene. \
            Make sure that scene was setted in root episode.
            """)
            assertionFailure()
            return
        }
        let presentedView = PresentedView(view: view, transition: transition.asAny())
        presentedViews.append(presentedView)
        transition.enter(node: view.node, in: scene.overlay)
    }

    func removeView<Transition: NodeTransition>(
        _ view: View,
        transition: Transition
    ) where Transition.Node == SKNode {
        guard let scene else {
            logger.error("""
            Tried to remove view \(view) from episode \(self) without scene. \
            Make sure that scene was setted in root episode.
            """)
            assertionFailure()
            return
        }
        presentedViews.removeAll { $0.view === view }
        transition.leave(node: view.node, in: scene.overlay)
    }

    func addView(_ view: View) {
        addView(view, transition: defaultOverlayTransition)
        view.layout()
    }

    func removeView(_ view: View) {
        removeView(view, transition: defaultOverlayTransition)
    }

    func addObject<Transition: NodeTransition>(
        _ object: SceneObject,
        transition: Transition
    ) where Transition.Node == SCNNode {
        guard let scene else {
            logger.error("""
            Tried to add object \(object) to episode \(self) without scene. \
            Make sure that scene was setted in root episode.
            """)
            assertionFailure()
            return
        }
        let presentedObject = PresentedObject(object: object, transition: transition.asAny())
        presentedObjects.append(presentedObject)
        transition.enter(node: object.node, in: scene.scene3d.rootNode)
    }

    func removeObject<Transition: NodeTransition>(
        _ object: SceneObject,
        transition: Transition
    ) where Transition.Node == SCNNode {
        guard let scene else {
            logger.error("""
            Tried to remove object \(object) from episode \(self) without scene. \
            Make sure that scene was setted in root episode.
            """)
            assertionFailure()
            return
        }
        presentedObjects.removeAll { $0.object === object }
        transition.leave(node: object.node, in: scene.scene3d.rootNode)
    }

    func addObject(_ object: SceneObject) {
        addObject(object, transition: BasicSceneTransition())
    }

    func removeObject(_ object: SceneObject) {
        removeObject(object, transition: BasicSceneTransition())
    }
}

// MARK: - Models

extension BaseGameEpisode {
    private struct PresentedView {
        let view: View
        let transition: AnyNodeTransition<SKNode>
    }

    private struct PresentedObject {
        let object: SceneObject
        let transition: AnyNodeTransition<SCNNode>
    }
}
