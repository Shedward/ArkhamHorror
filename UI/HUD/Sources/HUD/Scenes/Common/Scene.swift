//
//  Scene.swift
//  
//
//  Created by Vladislav Maltsev on 11.02.2023.
//

import SpriteKit
import Prelude


open class Scene<ViewModel: SceneViewModel>: SKScene
{
    public var viewModel: ViewModel
    private let logger = Logger()

    public init(size: CGSize, viewModel: ViewModel) {
        self.viewModel = viewModel
        super.init(size: size)
    }

    public required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
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
        viewModel.sceneDidLoad()
    }

    open func setup() {
        self.anchorPoint = .init(x: 0.5, y: 0.5)
    }
}
