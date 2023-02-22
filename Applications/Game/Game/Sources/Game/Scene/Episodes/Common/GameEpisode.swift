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
    func begin() async
    func end() async
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

    func begin() async {
        viewModel.episode = self as? ViewModel.Episode
        if viewModel.episode == nil {
            logger.error("""
            GameEpisode failed to cast episode \(self) \
            to \(ViewModel.Episode.self)
            """)
            assertionFailure()
        }

        await willBegin()
        viewModel.didBegin()
    }

    func willBegin() async {
    }

    func end() async {
        viewModel.willEnd()
        await removeAll()
        await didEnd()
    }

    func didEnd() async {
    }

    func startEpisode(_ episode: GameEpisodeProtocol) async {
        await scene?.startEpisode(episode)
    }

    func endEpisode() async {
        await scene?.endEpisode(self)
    }

    func layout() {
        presentedViews.forEach { $0.view.layout() }
    }

    func removeAll() async {
        await withTaskGroup(of: Void.self) { group in
            for presentedObject in presentedObjects {
                group.addTask {
                    await self.removeObject(presentedObject.object, transition: presentedObject.transition)
                }
            }
            for presentedView in presentedViews {
                group.addTask {
                    await self.removeView(presentedView.view, transition: presentedView.transition)
                }
            }
        }
    }

    func addView<Transition: NodeTransition>(
        _ view: View,
        transition: Transition
    ) async where Transition.Node == SKNode {
        guard let scene else { return }
        let presentedView = PresentedView(view: view, transition: transition.asAny())
        presentedViews.append(presentedView)
        await transition.enter(node: view.node, in: scene.overlay)
    }

    func removeView<Transition: NodeTransition>(
        _ view: View,
        transition: Transition
    ) async where Transition.Node == SKNode {
        guard let scene else { return }
        presentedViews.removeAll { $0.view === view }
        await transition.leave(node: view.node, in: scene.overlay)
    }

    func addView(_ view: View) async {
        await addView(view, transition: BasicSpriteTransition())
        view.layout()
    }

    func removeView(_ view: View) async {
        await removeView(view, transition: BasicSpriteTransition())
    }

    func addObject<Transition: NodeTransition>(
        _ object: SceneObject,
        transition: Transition
    ) async where Transition.Node == SCNNode {
        guard let scene else { return }
        let presentedObject = PresentedObject(object: object, transition: transition.asAny())
        presentedObjects.append(presentedObject)
        await transition.enter(node: object.node, in: scene.scene3d.rootNode)
    }

    func removeObject<Transition: NodeTransition>(
        _ object: SceneObject,
        transition: Transition
    ) async where Transition.Node == SCNNode {
        guard let scene else { return }
        presentedObjects.removeAll { $0.object === object }
        await transition.leave(node: object.node, in: scene.scene3d.rootNode)
    }

    func addObject(_ object: SceneObject) async {
        await addObject(object, transition: BasicSceneTransition())
    }

    func removeObject(_ object: SceneObject) async {
        await removeObject(object, transition: BasicSceneTransition())
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
