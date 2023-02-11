//
//  ErrorAlert.swift
//  
//
//  Created by Vladislav Maltsev on 11.02.2023.
//

import SpriteKit
import DesignSystem
import Prelude

public final class ErrorAlert: View {
    public let node: SKNode

    private let designSystem = DesignSystem.default

    private let messageLabel = Label(textKind: \.failure.message)
    private let frame = Frame(stroke: \.tint.bad, insets: .init(uniform: 16), fill: \.fixed.black)
    private let secondaryBorder = Shape(stroke: \.tint.bad, fill: \.fixed.black)
    private var stack: Stack?

    public init(error: Error? = nil, preferredWidth: CGFloat = 256) {
        self.node = SKNode()

        secondaryBorder.node.position = .init(x: 8, y: 8)
        node.addChild(secondaryBorder.node)

        let okButton = TextButton(
            text: Localized.string("DISMISS"),
            textKind: \.failure.message,
            onTap: { [weak self] in
                self?.display(nil)
            }
        )

        messageLabel.preferredWidth = preferredWidth
        messageLabel.numberOfLines = 0
        messageLabel.lineBreakMode = .byWordWrapping

        let stack = Stack(axis: .vertical, spacing: 16) {
            Label(text: Localized.string("Failure"), textKind: \.failure.title)
            messageLabel
            okButton
        }
        self.stack = stack

        display(nil)
        frame.node.addChild(stack.node)
        node.addChild(frame.node)
    }

    public func display(_ error: Error?) {
        if let error {
            messageLabel.text = error.localizedDescription

            stack?.layoutSubviews()
            let frameRect = frame.reframe()
            secondaryBorder.path = CGPath(rect: frameRect, transform: nil)
            node.isHidden = false
        } else {
            node.isHidden = true
        }
    }

    public func display<Success, Error>(_ result: Result<Success, Error>) {
        switch result {
        case .success:
            display(nil)
        case .failure(let failure):
            display(failure)
        }
    }

    public func display<Success>(_ loading: Loading<Success>) {
        display(loading.error)
    }
}
