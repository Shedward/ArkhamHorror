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
    private let designSystem = DesignSystem.default

    private let messageLabel: Label
    private let frame = Frame(stroke: \.tint.bad, insets: .init(uniform: 16), fill: \.fixed.black)
    private let secondaryBorder = Shape(stroke: \.tint.bad, fill: \.fixed.black)
    private var stack: Stack?

    public init(error: Error? = nil, preferredWidth: CGFloat = 256) {
        messageLabel = Label.multiline(textKind: \.failure.message, preferredWidth: preferredWidth)
        secondaryBorder.node.position = .init(x: 8, y: 8)
        super.init()

        let okButton = TextButton(
            text: Localized.string("DISMISS"),
            textKind: \.failure.message,
            onTap: { [weak self] in
                self?.display(nil)
            }
        )

        let stack = Stack(axis: .vertical, spacing: 16) {
            Label(text: Localized.string("Failure"), textKind: \.failure.title)
            messageLabel
            okButton
        }
        self.stack = stack

        addChild(secondaryBorder)
        addChild(frame)
        frame.addChild(stack)
        display(nil)
    }

    public func display(_ error: Error?) {
        if let error {
            messageLabel.text = error.localizedDescription
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

    public override func layoutSubviews() {
        super.layoutSubviews()

        let frameRect = frame.lastFrame
        secondaryBorder.path = CGPath(rect: frameRect, transform: nil) 
    }
}
