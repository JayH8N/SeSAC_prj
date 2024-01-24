//
//  NSMutableAttributedString.swift
//  SeSAC_Talk
//
//  Created by hoon on 1/8/24.
//

import UIKit

extension NSMutableAttributedString {
    @discardableResult
    func setColor(_ color: UIColor, forText text: String) -> NSMutableAttributedString {
        let range = (string as NSString).range(of: text)
        addAttribute(.foregroundColor, value: color, range: range)
        return self
    }
}
