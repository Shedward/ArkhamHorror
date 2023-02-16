//
//  Scene.swift
//  
//
//  Created by Vladislav Maltsev on 11.02.2023.
//

import SpriteKit
import Prelude


@MainActor
open class Scene<ViewModel: SceneViewModel>: SKScene {
    public var viewModel: ViewModel
    private let logger = Logger()
    private var childs: [View] = []

    public init(size: CGSize, viewModel: ViewModel) {
        self.viewModel = viewModel
        super.init(size: size)
    }

    public required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    public func addChildView(_ view: View) {
        childs.append(view)
        view.layout()
        addChild(view.node)
    }

    public func removeChild(_ view: View) {
        childs = childs.filter { $0 !== view }
        view.node.removeFromParent()
    }

    public func layout() {
        childs.forEach { $0.layout() }
    }

    open override func sceneDidLoad() {
        super.sceneDidLoad()

        viewModel.scene = (self as? ViewModel.Scene)
        if viewModel.scene == nil {
            logger.error("""
            Failed to cast view model \(viewModel) to expected \
            type \(ViewModel.Scene.self). View model was not setted.
            """)
        }

        setup()
        layout()
        viewModel.sceneDidLoad()
    }

    open func setup() {
        self.name = String(describing: type(of: self))
        self.backgroundColor = .black
        self.anchorPoint = .init(x: 0.5, y: 0.5)
    }
}
