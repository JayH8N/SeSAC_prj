//
//  UIButton.swift
//  Pantry
//
//  Created by hoon on 2023/09/28.
//

import UIKit

extension UIButton {
    func setBackgroundColor(_ backgroundColor: UIColor, for state: UIControl.State) {
        self.setBackgroundImage(.pixel(ofColor: backgroundColor), for: state)
    }
}

extension UIButton {
    static func makeHighlightedButton(withImageName imageName: String) -> UIButton {
        let buttonImage = UIImage.SymbolConfiguration(pointSize: 30, weight: .regular, scale: .small)
        let image = UIImage(systemName: imageName, withConfiguration: buttonImage)
        
        let button = HighlightedButton()
        button.setImage(image, for: .normal)
        
        return button
    }
}
