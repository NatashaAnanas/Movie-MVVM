// UIView+Extension.swift
// Copyright © Natasha Ananas. All rights reserved.

import UIKit

/// Расширение для добавления UIView элементов
extension UIView {
    func addSubviews(_ views: UIView...) {
        for view in views {
            addSubview(view)
        }
    }
}
