//
//  BorderButton.swift
//  SeSACgram
//
//  Created by hoon on 11/18/23.
//

import UIKit

final class BorderButton: UIButton {
    
    private let scaleDownTransform = CGAffineTransform(scaleX: 0.95, y: 0.95)
    
    init(title: String) {
        super.init(frame: .zero)
        
        setTitle(title, for: .normal)
        titleLabel?.font = Constants.Font.themeFont
        setTitleColor(Constants.Color.LightGreen, for: .normal)
        backgroundColor = .clear
        layer.borderColor = Constants.Color.LightGreen.cgColor
        layer.borderWidth = 1
        layer.cornerRadius = Constants.Size.buttonCornerRadius
        clipsToBounds = true
        
        addTarget(self, action: #selector(buttonPressed), for: .touchDown)
        addTarget(self, action: #selector(buttonReleased), for: .touchUpInside)
        addTarget(self, action: #selector(buttonReleased), for: .touchUpOutside)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //버튼 눌리는 경우
    @objc private func buttonPressed() {
        HapticManager.shared.viberateForInteraction(style: .light)
        UIView.animate(withDuration: 0.2) {
            self.transform = self.scaleDownTransform
        }
    }
    
    // 버튼이 떼어지는 경우
    @objc private func buttonReleased() {
        UIView.animate(withDuration: 0.2) {
            self.transform = .identity
        }
    }
    
}
