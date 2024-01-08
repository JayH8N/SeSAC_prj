//
//  LoginButton.swift
//  SeSAC_Talk
//
//  Created by hoon on 1/8/24.
//

import UIKit

final class LoginButton: UIButton {
    
    private let iconImage = UIImageView().then {
        $0.contentMode = .scaleAspectFit
    }
    
    init(text: String, type: LoginCase) {
        super.init(frame: .zero)
        setUI(type: type)
        self.setTitle(text, for: .normal)
    }
    
    enum LoginCase {
        case apple
        case kakao
        case email
    }
    
    private func setUI(type: LoginCase) {
        self.titleLabel?.font = Constants.Typography.Title2
        switch type {
        case .apple:
            self.backgroundColor = UIColor.black
            self.setTitleColor(UIColor.white, for: .normal)
            setIconImage(image: .apple)
        case .kakao:
            self.backgroundColor = UIColor(hexString: "#FEE500")
            self.setTitleColor(UIColor.black, for: .normal)
            setIconImage(image: .kakao)
        case .email:
            self.backgroundColor = Constants.Color.Brand.Green
            self.setTitleColor(UIColor.white, for: .normal)
            setIconImage(image: .email)
        }
        layer.cornerRadius = 8
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setIconImage(image: UIImage) {
        iconImage.image = image
        addSubview(iconImage)
        iconImage.snp.makeConstraints {
            $0.size.equalTo(18)
            $0.centerY.equalTo(self.titleLabel!)
            $0.trailing.equalTo(self.titleLabel!.snp.leading).offset(-8)
        }
    }
    
    
}
