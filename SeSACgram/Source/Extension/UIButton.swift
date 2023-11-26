//
//  UIButton.swift
//  SeSACgram
//
//  Created by hoon on 11/15/23.
//

import UIKit
import Then

extension UIButton {
    func setBackgroundColor(_ backgroundColor: UIColor, for state: UIControl.State) {
        self.setBackgroundImage(.pixel(ofColor: backgroundColor), for: state)
    }
    
    //반응형 버튼
    static func responsiveButton(title: String, color: UIColor, isEnable: Bool) -> UIButton {
        let action = UIAction(title: "") { _ in
            HapticManager.shared.viberateForInteraction(style: .light)
        }
        let button = UIButton(type: .system, primaryAction: action)
        button.setTitle(title, for: .normal)
        button.tintColor = Constants.Color.Appearance
        button.setBackgroundColor(color, for: .normal)
        button.layer.cornerRadius = Constants.Size.buttonCornerRadius
        button.clipsToBounds = true
        button.titleLabel?.font = Constants.Font.themeFont
        button.isEnabled = isEnable
        return button
    }
}
