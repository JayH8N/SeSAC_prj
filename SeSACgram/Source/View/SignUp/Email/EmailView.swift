//
//  EmailView.swift
//  SeSACgram
//
//  Created by hoon on 11/15/23.
//

import UIKit
import Then
import SnapKit

final class EmailView: BaseView {
    
    private let titleLabel = SignUPTitleLabel(title: "아이디 입력")
    private let subTitleLabel = UILabel().then {
        $0.text = "회원 가입에 사용할 아이디를 입력해주세요"
        $0.font = Constants.Font.HeaderSubTitle
        $0.numberOfLines = 2
    }
    
    let emailTextField = CustomTextField(placeholder: "아이디 입력", style: .id)
    let resultMessage = UILabel().then {
        $0.font = Constants.Font.BodySize
        $0.textColor = UIColor.red
        $0.isHidden = true
    }
    let nextButton = UIButton.responsiveButton(title: "다음", color: Constants.Color.DeepGreen, isEnable: false)
    
    lazy var emailTextFieldStackView = UIStackView(arrangedSubviews: [emailTextField, resultMessage]).then {
        $0.axis = .vertical
        $0.spacing = 4
    }
    
    override func configureView() {
        addSubview(titleLabel)
        addSubview(subTitleLabel)
        //addSubview(emailTextField)
        addSubview(emailTextFieldStackView)
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
        
        emailTextField.snp.makeConstraints {
            $0.height.equalTo(Constants.Frame.textFieldHeight)
        }
        
        emailTextFieldStackView.snp.makeConstraints {
            $0.top.equalTo(subTitleLabel.snp.bottom).offset(22)
            $0.leading.trailing.equalToSuperview().inset(24)
        }
        
        nextButton.snp.makeConstraints {
            $0.top.equalTo(emailTextFieldStackView.snp.bottom).offset(22)
            $0.leading.trailing.equalToSuperview().inset(24)
            $0.height.equalTo(Constants.Frame.buttonHeight)
        }
    }
    
    
}
