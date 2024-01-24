//
//  Extension+UIButton.swift
//  Recap_2
//
//  Created by hoon on 2023/09/11.
//

import UIKit


extension UIButton {
    func setButtonImage(size: CGFloat, systemName: String) {
        let buttonImage = UIImage.SymbolConfiguration(pointSize: size, weight: .light, scale: .small)
        let image = UIImage(systemName: systemName, withConfiguration: buttonImage)
        setImage(image, for: .normal)
    }
}
