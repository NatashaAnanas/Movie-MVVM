// UIViewController+Extension.swift
// Copyright © Natasha Ananas. All rights reserved.

import UIKit

// MARK: - Private Constants

private enum Constant {
    static let okTextString = "OK"
}

/// Расширение для UIViewController(Alert)
extension UIViewController {
    func showAlert(title: String?, message: String, handler: StringHandler) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let alertControllerAction = UIAlertAction(title: Constant.okTextString, style: .default) { _ in
            let text = alertController.textFields?.first?.text ?? ""
            handler?(text)
        }
        alertController.addTextField()
        alertController.addAction(alertControllerAction)
        present(alertController, animated: true)
    }
}
