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

    private let titleLabel: Label
    private let messageLabel: Label
    private let actionButton: TextButton
    private let frame = Frame(stroke: \.tint.bad, insets: .init(uniform: 8), fill: \.fixed.black)
    private let secondaryBorder = Shape(stroke: \.tint.bad, fill: \.fixed.black)
    private var stack: Stack?
    private let logger = Logger()

    public init(error: Error? = nil, preferredWidth: CGFloat = 256) {
        titleLabel = Label(text: Localized.string("Failure"), textKind: \.failure.title)
        messageLabel = Label.multiline(textKind: \.failure.message, preferredWidth: preferredWidth)
        actionButton = TextButton(text: Localized.string("Dismiss"), textKind: \.failure.title, border: 3.0)
        secondaryBorder.node.position = .init(x: 8, y: 8)

        super.init()

        actionButton.onTap = { [weak self] in
            self?.display(nil)
        }

        let stack = Stack(axis: .vertical, spacing: 12) {
            titleLabel
            messageLabel
            actionButton
        }
        self.stack = stack

        addChild(secondaryBorder)
        addChild(frame)
        frame.addChild(stack)
        display(nil)
    }

    public func display(_ error: Error?) {
        if let error {
            logger.error("Alert: \(error)")
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

    public func configure(with data: Data) {
        node.isHidden = false
        titleLabel.text = data.title
        messageLabel.text = data.message
        actionButton.configure(with: data.actionButton)
    }

    public override func layoutSubviews() {
        super.layoutSubviews()

        let frameRect = frame.lastFrame
        secondaryBorder.path = CGPath(rect: frameRect, transform: nil) 
    }
}

extension ErrorAlert {
    public struct Data {
        public var title: String
        public var message: String
        public var actionButton: TextButton.Data

        public init(
            title: String = Localized.string("Failure"),
            message: String,
            actionButton: TextButton.Data
        ) {
            self.title = title
            self.message = message
            self.actionButton = actionButton
        }

        public init(
            title: String = Localized.string("Failure"),
            error: Error,
            actionButton: TextButton.Data
        ) {
            self.title = title
            self.message = error.localizedDescription
            self.actionButton = actionButton
        }
    }
}
