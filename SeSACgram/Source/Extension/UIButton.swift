//
//  UIButton.swift
//  SeSACgram
//
//  Created by hoon on 11/15/23.
//

import UIKit

extension UIButton {
    func setBackgroundColor(_ backgroundColor: UIColor, for state: UIControl.State) {
        self.setBackgroundImage(.pixel(ofColor: backgroundColor), for: state)
    }
}
