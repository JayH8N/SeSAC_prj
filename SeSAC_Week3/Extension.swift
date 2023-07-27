//
//  Extension.swift
//  SeSAC_Week3
//
//  Created by hoon on 2023/07/27.
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


extension UILabel {
    func configureTitleText() {
        self.textColor = .black
        self.font = .boldSystemFont(ofSize: 15)
        self.textAlignment = .left
    }
}

extension UIButton {
    func configureStyle(title: String, color: UIColor) {
        self.setTitle(title, for: .normal)
        self.layer.cornerRadius = 5
        self.setTitleColor(color, for: .normal)
    }
}

extension UITextField {
    func configureStyle(text: String, placeholder: String) {
        self.text = text
        self.borderStyle = .none
        self.placeholder = placeholder
    }
}
