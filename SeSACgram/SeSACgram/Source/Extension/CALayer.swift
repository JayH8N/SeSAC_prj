//
//  CALayer.swift
//  SeSACgram
//
//  Created by hoon on 11/28/23.
//

import Foundation

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
}
