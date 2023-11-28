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
        button.titleLabel?.font = Constants.Font.ButtonFont
        button.isEnabled = isEnable
        return button
    }
    
    //SFsymbol삽입 버튼
    static func makeHighlightedButton(withImageName imageName: String, size: CGFloat) -> UIButton {
        let buttonImage = UIImage.SymbolConfiguration(pointSize: size, weight: .regular, scale: .small)
        let image = UIImage(systemName: imageName, withConfiguration: buttonImage)
        
        let button = HighlightedButton()
        button.setImage(image, for: .normal)
        button.tintColor = Constants.Color.DeepGreen
        button.addTarget(self, action: #selector(hapticFeedBackGenerator), for: .touchUpInside)
        return button
    }
    
    @objc private static func hapticFeedBackGenerator() {
        HapticManager.shared.viberateForInteraction(style: .light)
    }
    
    
    
    
}
