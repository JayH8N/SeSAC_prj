//
//  Extension + CALayer.swift
//  Baemin
//
//  Created by hoon on 2023/08/26.
//

import UIKit

extension UIView {
    
    func roundCorners(cornerRadius: CGFloat, maskedCorners: CACornerMask) {
        clipsToBounds = true
        layer.cornerRadius = cornerRadius
        layer.maskedCorners = CACornerMask(arrayLiteral: maskedCorners)
    }
    

}

//extension + CALayer
func roundCorners(cornerRadius: CGFloat, maskedCorners: CACornerMask) {
    let border = CALayer()
    //clipsToBounds = true
    border.cornerRadius = cornerRadius
    border.maskedCorners = CACornerMask(arrayLiteral: maskedCorners)
}
