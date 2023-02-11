//
//  SceneViewModel.swift
//  
//
//  Created by Vladislav Maltsev on 11.02.2023.
//

public protocol SceneViewModel {
    associatedtype Scene

    var scene: Scene? { get set }

    func sceneDidLoad()
}
