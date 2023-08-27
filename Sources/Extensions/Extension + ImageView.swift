//
//  Extension + ImageView.swift
//  Media
//
//  Created by hoon on 2023/08/19.
//

import UIKit

extension UIImageView {
    func roundCorners(cornerRadius: CGFloat, maskedCorners: CACornerMask) {
        clipsToBounds = true
        layer.cornerRadius = cornerRadius
        layer.maskedCorners = CACornerMask(arrayLiteral: maskedCorners)
    }
}
