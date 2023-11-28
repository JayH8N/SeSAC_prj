//
//  SignInView.swift
//  SeSACgram
//
//  Created by hoon on 11/14/23.
//

import UIKit
import Then
import SnapKit
import NVActivityIndicatorView

final class SignInView: BaseView {
    
    private let logoImage = UIImageView().then {
        $0.image = Constants.Image.SeSAC_Logo
    }
    
    let emailTextField = CustomTextField(placeholder: "이메일 주소",
                                         style: .id)
    let pwTextField = CustomTextField(placeholder: "비밀번호",
                                      style: .pw)
    
    private lazy var loginTextFieldStackView = UIStackView(arrangedSubviews: [emailTextField, pwTextField]).then {
        $0.axis = .vertical
        $0.spacing = 20
        $0.distribution = .fillEqually
    }
    
    let signInButton = UIButton.responsiveButton(title: "로그인",
                                                 color: Constants.Color.DeepGreen, isEnable: true)
    
    let signUpButton = BorderButton(title: "새 계정 만들기")
    
    let indicator = NVActivityIndicatorView(frame: .zero,
                                            type: .ballPulse,
                                            color: .white,
                                            padding: 4).then {
        $0.isHidden = true
    }
    
    override func configureView() {
        addSubview(logoImage)
        addSubview(loginTextFieldStackView)
        addSubview(signInButton)
        signInButton.addSubview(indicator)
        addSubview(signUpButton)
    }
    
    override func setConstraints() {
        logoImage.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.centerY.equalToSuperview().multipliedBy(0.4)
            $0.size.equalTo(70)
        }
        
        loginTextFieldStackView.snp.makeConstraints {
            $0.top.equalTo(logoImage.snp.bottom).offset(160)
            $0.leading.trailing.equalToSuperview().inset(24)
            $0.height.equalToSuperview().multipliedBy(0.16)
        }
        
        signInButton.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview().inset(24)
            $0.height.equalTo(Constants.Frame.buttonHeight)
            $0.top.equalTo(loginTextFieldStackView.snp.bottom).offset(20)
        }
        
        indicator.snp.makeConstraints {
            $0.center.equalToSuperview()
            $0.height.equalTo(Constants.Frame.buttonHeight)
            $0.width.equalTo(60)
        }
        
        signUpButton.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview().inset(24)
            $0.height.equalTo(Constants.Frame.buttonHeight)
            $0.bottom.equalTo(self.snp.bottom).inset(45)
        }
    }
    
    
}
