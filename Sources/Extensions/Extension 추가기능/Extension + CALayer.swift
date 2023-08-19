//
//  Extension + CALayer.swift
//  Media
//
//  Created by hoon on 2023/08/19.
//

import UIKit

import UIKit

extension CALayer {
    func addBorder(_ arr_edge: [UIRectEdge], width: CGFloat, color: CGColor) {
        for edge in arr_edge {
            let border = CALayer()
            switch edge {
            case UIRectEdge.top:
                border.frame = CGRect.init(x: 0, y: 0, width: frame.width, height: width)
                break
            case UIRectEdge.bottom:
                border.frame = CGRect.init(x: 0, y: frame.height - width, width: frame.width, height: width)
                break
            case UIRectEdge.left:
                border.frame = CGRect.init(x: 0, y: 0, width: width, height: frame.height)
                break
            case UIRectEdge.right:
                border.frame = CGRect.init(x: frame.width - width, y: 0, width: width, height: frame.height)
                break
            default:
                break
            }
            border.backgroundColor = color //UIColor.black.cgColor
            self.addSublayer(border)
        }
    }
    
    //extension + CALayer
    func roundCorners(cornerRadius: CGFloat, maskedCorners: CACornerMask) {
        let border = CALayer()
        //clipsToBounds = true
        border.cornerRadius = cornerRadius
        border.maskedCorners = CACornerMask(arrayLiteral: maskedCorners)
    }
    
    //    .layerMinXMinYCorner : 왼쪽 상단
    //    .layerMaxXMinYCorner : 오른쪽 상단
    //    .layerMinXMaxYCorner : 왼쪽 하단
    //    .layerMaxXMaxYCorner : 오른쪽 하단
}
