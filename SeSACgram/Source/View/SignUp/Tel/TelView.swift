//
//  TelView.swift
//  SeSACgram
//
//  Created by hoon on 11/15/23.
//

import UIKit
import Then
import SnapKit

final class TelView: BaseView {
    
    private let titleLabel = SignUPTitleLabel(title: "휴대폰 번호 입력")
    private let subTitleLabel = UILabel().then {
        $0.text = "회원님에게 연락할 수 있는 휴대폰 번호를 입력하세요."
        $0.font = Constants.Font.HeaderSubTitle
        $0.numberOfLines = 2
    }
    
    let numLimit: Int = 13
    let telTextField = CustomTextField(placeholder: "휴대폰 번호", style: .id).then {
        $0.keyboardType = .numberPad
    }
    let nextButton = UIButton.responsiveButton(title: "건너뛰기", color: Constants.Color.DeepGreen).then {
        $0.isEnabled = true
    }
    
    override func configureView() {
        addSubview(titleLabel)
        addSubview(subTitleLabel)
        addSubview(telTextField)
        addSubview(nextButton)
    }
    
    override func setConstraints() {
        titleLabel.snp.makeConstraints {
            $0.leading.equalToSuperview().inset(24)
            $0.top.equalTo(self.safeAreaLayoutGuide).inset(20)
        }
        
        subTitleLabel.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview().inset(24)
            $0.top.equalTo(titleLabel.snp.bottom).offset(8)
        }
        
        telTextField.snp.makeConstraints {
            $0.top.equalTo(subTitleLabel.snp.bottom).offset(22)
            $0.leading.trailing.equalToSuperview().inset(24)
            $0.height.equalTo(Constants.Frame.textFieldHeight)
        }
        
        nextButton.snp.makeConstraints {
            $0.top.equalTo(telTextField.snp.bottom).offset(22)
            $0.leading.trailing.equalToSuperview().inset(24)
            $0.height.equalTo(Constants.Frame.buttonHeight)
        }
    }
}
