//
//  UIButton.swift
//  Pantry
//
//  Created by hoon on 2023/09/28.
//

import UIKit

extension UIButton {
    func setBackgroundColor(_ backgroundColor: UIColor, for state: UIControl.State) {
        self.setBackgroundImage(.pixel(ofColor: backgroundColor), for: state)
    }
}

extension UIButton {
    static func makeHighlightedButton(withImageName imageName: String, size: CGFloat) -> UIButton {
        let buttonImage = UIImage.SymbolConfiguration(pointSize: size, weight: .regular, scale: .small)
        let image = UIImage(systemName: imageName, withConfiguration: buttonImage)
        
        let button = HighlightedButton()
        button.setImage(image, for: .normal)
        
        button.addTarget(self, action: #selector(hapticFeedBackGenerator), for: .touchUpInside)
        
        return button
    }
    
    @objc private static func hapticFeedBackGenerator() {
        HapticFeedbackManager.shared.provideFeedback()
    }
    
    static func makeHighlightedButton2(withImageName imageName: String) -> UIButton {
        let image = UIImage(named: imageName)
        
        let button = HighlightedButton()
        button.setImage(image, for: .normal)
        
        button.addTarget(self, action: #selector(hapticFeedBackGenerator), for: .touchUpInside)
        
        return button
    }
    
}

extension UIButton {
    static func uiButtonConfigure(imageName: String, title: String) -> UIButton {
        let uiButton = UIButton()
        let symbolConfig = UIImage.SymbolConfiguration(pointSize: 24, weight: .bold, scale: .small)
        
        let image = UIImage(systemName: imageName, withConfiguration: symbolConfig)
        uiButton.setImage(image, for: .normal)
        uiButton.tintColor = .black
        uiButton.backgroundColor = .white
        
        var attString = AttributedString(title)
        attString.font = .systemFont(ofSize: 11, weight: .light)
        attString.foregroundColor = .white
        var config = UIButton.Configuration.plain()
        config.attributedTitle = attString
        config.contentInsets = .init(top: 10, leading: 10, bottom: 10, trailing: 10)
        config.image = UIImage(systemName: imageName)
        config.imagePadding = 0
        config.imagePlacement = .top
        config.baseBackgroundColor = .white
        uiButton.configuration = config
        uiButton.layer.shadowColor = UIColor.black.cgColor   //그림자 색깔
        uiButton.layer.shadowOffset = CGSize(width: 0, height: 0)  //태양이 보는 시점
        uiButton.layer.shadowRadius = 10  //그림자 코너깎임정도
        uiButton.layer.shadowOpacity = 0.5   //그림자 투명도
        
        return uiButton
    }
}
