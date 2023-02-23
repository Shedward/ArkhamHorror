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
protocol GameEpisodeProtocol: AnyObject {
    var scene: GameScene? { get set }
    func begin()
    func end()
}

@MainActor
class GameEpisode<ViewModel: GameEpisodeViewModel>: GameEpisodeProtocol {
    private var presentedViews: [PresentedView] = []
    private var presentedObjects: [PresentedObject] = []
    private var viewModel: ViewModel
    private let logger = Logger()

    weak var scene: GameScene?

    var overlaySize: CGSize {
        scene?.overlay.size ?? .zero
    }

    init(viewModel: ViewModel) {
        self.viewModel = viewModel
    }

    func begin() {
        viewModel.episode = self as? ViewModel.Episode
        if viewModel.episode == nil {
            logger.error("""
            GameEpisode failed to cast episode \(self) \
            to \(ViewModel.Episode.self)
            """)
            assertionFailure()
        }

        willBegin()
        viewModel.didBegin()
    }

    func willBegin() {
    }

    func end() {
        viewModel.willEnd()
        removeAll()
        didEnd()
    }

    func didEnd() {
    }

    func startEpisode(_ episode: GameEpisodeProtocol) {
        scene?.startEpisode(episode)
    }

    func endEpisode() async {
        scene?.endEpisode(self)
    }

    func layout() {
        presentedViews.forEach { $0.view.layout() }
    }

    func removeAll() {
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
        guard let scene else { return }
        let presentedView = PresentedView(view: view, transition: transition.asAny())
        presentedViews.append(presentedView)
        transition.enter(node: view.node, in: scene.overlay)
    }

    func removeView<Transition: NodeTransition>(
        _ view: View,
        transition: Transition
    ) where Transition.Node == SKNode {
        guard let scene else { return }
        presentedViews.removeAll { $0.view === view }
        transition.leave(node: view.node, in: scene.overlay)
    }

    func addView(_ view: View) {
        addView(view, transition: BasicSpriteTransition())
        view.layout()
    }

    func removeView(_ view: View) {
        removeView(view, transition: BasicSpriteTransition())
    }

    func addObject<Transition: NodeTransition>(
        _ object: SceneObject,
        transition: Transition
    ) where Transition.Node == SCNNode {
        guard let scene else { return }
        let presentedObject = PresentedObject(object: object, transition: transition.asAny())
        presentedObjects.append(presentedObject)
        transition.enter(node: object.node, in: scene.scene3d.rootNode)
    }

    func removeObject<Transition: NodeTransition>(
        _ object: SceneObject,
        transition: Transition
    ) where Transition.Node == SCNNode {
        guard let scene else { return }
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

extension GameEpisode {
    private struct PresentedView {
        let view: View
        let transition: AnyNodeTransition<SKNode>
    }

    private struct PresentedObject {
        let object: SceneObject
        let transition: AnyNodeTransition<SCNNode>
    }
}
