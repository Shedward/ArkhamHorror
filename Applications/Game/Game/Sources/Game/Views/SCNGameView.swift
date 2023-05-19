//
//  SCNGameView.swift
//  
//
//  Created by Vladislav Maltsev on 17.05.2023.
//

import SceneKit
import Scenes

#if os(macOS)
import AppKit
typealias UGestureRecognizer = NSGestureRecognizer
typealias UGestureRecognizerDelegate = NSGestureRecognizerDelegate
#elseif os(iOS)
import UIKit
typealias UGestureRecognizer = UIGestureRecognizer
typealias UGestureRecognizerDelegate = UIGestureRecognizerDelegate
#endif

final class SCNGameView: SCNView {

    private var tapGestureRecognizer: UGestureRecognizer?

    #if os(macOS)

    override init(frame: NSRect, options: [String : Any]? = nil) {
        super.init(frame: frame, options: options)
        configureView()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    #elseif os(iOS)
    #endif

    private func configureView() {
        let recognizer = NSClickGestureRecognizer(target: self, action: #selector(onTap))
        recognizer.delaysPrimaryMouseButtonEvents = false
        tapGestureRecognizer = recognizer
        addGestureRecognizer(recognizer)
    }

    @objc
    private func onTap(_ gesture: UGestureRecognizer) {
        let point = gesture.location(in: self)

        let hitResults = hitTest(
            point,
            options: [
                .categoryBitMask: NodeCategory.userInteractionEnabled.asNSNumber(),
            ]
        )

        hitResults.forEach { result in
            if let selectableNode = result.node as? SCNSelectableNode {
                selectableNode.didTap()
            }
        }
    }
}
