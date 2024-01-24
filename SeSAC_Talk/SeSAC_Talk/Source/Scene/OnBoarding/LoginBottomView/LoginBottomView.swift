//
//  LoginBottomView.swift
//  SeSAC_Talk
//
//  Created by hoon on 1/8/24.
//

import UIKit
import Then
import SnapKit

final class LoginBottomView: BaseView {
    
    //MARK: - 로그인 버튼
    let apple = LoginButton(text: "Apple로 계속하기", type: .apple)
    let kakao = LoginButton(text: "카카오로 계속하기", type: .kakao)
    let email = LoginButton(text: "이메일로 계속하기", type: .email)
    
    
    //MARK: - 회원가입버튼
    let signUPLabel = UILabel().then {
        $0.text = "또는 새롭게 회원가입 하기"
        $0.textAlignment = .center
        $0.font = Constants.Typography.Title2
        $0.isUserInteractionEnabled = true
        
        let attributedText = NSMutableAttributedString(string: $0.text ?? "")
        attributedText.setColor(Constants.Color.Brand.Green, forText: "새롭게 회원가입 하기")
        $0.attributedText = attributedText
    }
    
    override func configureView() {
        addSubview(apple)
        addSubview(kakao)
        addSubview(email)
        addSubview(signUPLabel)
    }
    
    override func setConstraints() {
        apple.snp.makeConstraints {
            $0.horizontalEdges.equalToSuperview().inset(35)
            $0.height.equalTo(44)
            $0.top.equalToSuperview().inset(42)
        }
        kakao.snp.makeConstraints {
            $0.top.equalTo(apple.snp.bottom).offset(16)
            $0.height.equalTo(apple)
            $0.horizontalEdges.equalTo(apple)
        }
        email.snp.makeConstraints {
            $0.top.equalTo(kakao.snp.bottom).offset(16)
            $0.height.equalTo(apple)
            $0.horizontalEdges.equalTo(apple)
        }
        signUPLabel.snp.makeConstraints {
            $0.top.equalTo(email.snp.bottom).offset(16)
            $0.horizontalEdges.equalTo(apple)
        }
    }
}
