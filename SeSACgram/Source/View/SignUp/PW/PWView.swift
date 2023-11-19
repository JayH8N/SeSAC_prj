//
//  PWView.swift
//  SeSACgram
//
//  Created by hoon on 11/15/23.
//

import UIKit
import Then
import SnapKit

final class PWView: BaseView {
    
    private let titleLabel = SignUPTitleLabel(title: "비밀번호 입력")
    private let subTitleLabel = UILabel().then {
        $0.text = "회원 가입에 사용할 비밀번호를 입력해주세요"
        $0.font = Constants.Font.HeaderSubTitle
    }
    
    private let pwTextField = CustomTextField(placeholder: "비밀번호", style: .pw)
    private let pwTextFieldCheck = CustomTextField(placeholder: "비밀번호 확인", style: .pw)
    
    let nextButton = UIButton.responsiveButton(title: "다음", color: Constants.Color.DeepGreen)
    
    override func configureView() {
        addSubview(titleLabel)
        addSubview(subTitleLabel)
        addSubview(pwTextField)
        addSubview(pwTextFieldCheck)
        addSubview(nextButton)
    }
    
    
    override func setConstraints() {
        titleLabel.snp.makeConstraints {
            $0.leading.equalToSuperview().inset(24)
            $0.top.equalTo(self.safeAreaLayoutGuide).inset(20)
        }
        
        subTitleLabel.snp.makeConstraints {
            $0.leading.equalTo(titleLabel)
            $0.top.equalTo(titleLabel.snp.bottom).offset(8)
        }
        
        pwTextField.snp.makeConstraints {
            $0.top.equalTo(subTitleLabel.snp.bottom).offset(22)
            $0.leading.trailing.equalToSuperview().inset(24)
            $0.height.equalTo(Constants.Frame.textFieldHeight)
        }
        
        pwTextFieldCheck.snp.makeConstraints {
            $0.top.equalTo(pwTextField.snp.bottom).offset(10)
            $0.leading.trailing.equalToSuperview().inset(24)
            $0.height.equalTo(Constants.Frame.textFieldHeight)
        }
        
        nextButton.snp.makeConstraints {
            $0.top.equalTo(pwTextFieldCheck.snp.bottom).offset(22)
            $0.leading.trailing.equalToSuperview().inset(24)
            $0.height.equalTo(Constants.Frame.buttonHeight)
        }
    }
}
