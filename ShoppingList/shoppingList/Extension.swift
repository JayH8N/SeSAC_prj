//
//  Extension.swift
//  shoppingList
//
//  Created by hoon on 2023/07/28.
//

import UIKit

extension UITableViewController {
    func showAlert(title: String, message: String? = nil) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let ok = UIAlertAction(title: "확인", style: .default)
        alert.addAction(ok)
        present(alert, animated: true)
    }
}

extension UIView {
    func configureUIView(corner: CGFloat, color: UIColor) {
        self.layer.cornerRadius = corner
        self.backgroundColor = color
    }
}

extension UITextField {
    func configureUITextField(plalceholder: String) {
        self.borderStyle = .none
        self.placeholder = plalceholder
    }
}

extension UIButton {
    func confirgureUIButton(title: String, color: UIColor, corner: CGFloat) {
        self.setTitle(title, for: .normal)
        self.backgroundColor = color
        self.layer.cornerRadius = corner

    }
}
