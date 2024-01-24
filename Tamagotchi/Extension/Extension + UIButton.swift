//
//  Extension + UIButton.swift
//  Tamagotchi
//
//  Created by hoon on 2023/08/17.
//

import UIKit

extension UIButton {
    func roundCorners(cornerRadius: CGFloat, maskedCorners: CACornerMask) {
        clipsToBounds = true
        layer.cornerRadius = cornerRadius
        layer.maskedCorners = CACornerMask(arrayLiteral: maskedCorners)
    }
}
