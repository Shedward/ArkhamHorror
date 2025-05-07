//
//  DisplayingError.swift
//  
//
//  Created by Vladislav Maltsev on 03.03.2023.
//

import HUD
import Prelude
import DesignSystem

protocol DisplayingError {
    func displayError(_ error: Error, onDismiss: (() -> Void)?) async
}

extension BaseGameEpisode: DisplayingError {
    func displayError(_ error: Error) async {
        await displayError(error, onDismiss: nil)
    }

    func displayError(_ error: Error, onDismiss: (() -> Void)?) async {
        let errorAlert = ErrorAlert()
        let data = ErrorAlert.Data(
            error: error,
            actionButton: TextButton.Data(
                title: Localized.string("Dismiss"),
                onTap: { [weak self, weak errorAlert] in
                    guard let self, let errorAlert else { return }
                    self.removeView(errorAlert, transition: FadeSpriteTransition())
                    onDismiss?()
                }
            )
        )
        errorAlert.configure(with: data)
        addView(errorAlert)
        layout()
    }
}
