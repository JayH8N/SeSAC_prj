//
//  NicknameView.swift
//  SeSACgram
//
//  Created by hoon on 11/15/23.
//

import UIKit
import Then
import SnapKit

final class NicknameView: BaseView {
    
    private let titleLabel = SignUPTitleLabel(title: "닉네임 입력")
    private let subTitleLabel = UILabel().then {
        $0.text = "친구들이 회원님을 찾을 수 있도록 닉네임을 추가하세요."
        $0.font = Constants.Font.HeaderSubTitle
        $0.numberOfLines = 2
    }
    
    private let nickNameTextField = CustomTextField(placeholder: "닉네임", style: .id)
    let nextButton = UIButton.responsiveButton(title: "다음", color: Constants.Color.DeepGreen)
    
    override func configureView() {
        addSubview(titleLabel)
        addSubview(subTitleLabel)
        addSubview(nickNameTextField)
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
        
        nickNameTextField.snp.makeConstraints {
            $0.top.equalTo(subTitleLabel.snp.bottom).offset(22)
            $0.leading.trailing.equalToSuperview().inset(24)
            $0.height.equalTo(Constants.Frame.textFieldHeight)
        }
        
        nextButton.snp.makeConstraints {
            $0.top.equalTo(nickNameTextField.snp.bottom).offset(22)
            $0.leading.trailing.equalToSuperview().inset(24)
            $0.height.equalTo(Constants.Frame.buttonHeight)
        }
    }
}
