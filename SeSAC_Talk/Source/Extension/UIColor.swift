//
//  UIColor.swift
//  SeSAC_Talk
//
//  Created by hoon on 1/3/24.
//

import UIKit

extension UIColor {
    convenience init(hex: UInt32, alpha: CGFloat = 1.0) {
            let red = CGFloat((hex & 0xFF0000) >> 16) / 255.0
            let green = CGFloat((hex & 0x00FF00) >> 8) / 255.0
            let blue = CGFloat(hex & 0x0000FF) / 255.0

            self.init(red: red, green: green, blue: blue, alpha: alpha)
        }

        convenience init(hexString: String, alpha: CGFloat = 1.0) {
            var hexSanitized = hexString.trimmingCharacters(in: .whitespacesAndNewlines)
            hexSanitized = hexSanitized.replacingOccurrences(of: "#", with: "")

            var rgb: UInt64 = 0

            Scanner(string: hexSanitized).scanHexInt64(&rgb)

            self.init(hex: UInt32(rgb), alpha: alpha)
        }
}
