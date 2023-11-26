//
//  BirthView.swift
//  SeSACgram
//
//  Created by hoon on 11/15/23.
//

import UIKit
import Then
import SnapKit

final class BirthView: BaseView {
    
    private let titleLabel = SignUPTitleLabel(title: "생년월일 입력")
    private let subTitleLabel = UILabel().then {
        $0.text = "비즈니스, 반려동물 또는 기타 목적으로 이 계정을 만드는 경우에도 회원님의 실제 생년월일을 사용하세요. 이 생년월일 정보는 회원님이 공유하지 않는 한 다른 사람에게 공개되지 않습니다."
        $0.font = Constants.Font.HeaderSubTitle
        $0.numberOfLines = 0
    }
    
    let birthTextField = CustomTextField(placeholder: "생년월일", style: .birth)
    let nextButton = UIButton.responsiveButton(title: "회원가입", color: Constants.Color.DeepGreen, isEnable: true)
    
    override func configureView() {
        addSubview(titleLabel)
        addSubview(subTitleLabel)
        addSubview(birthTextField)
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
        
        birthTextField.snp.makeConstraints {
            $0.top.equalTo(subTitleLabel.snp.bottom).offset(22)
            $0.leading.trailing.equalToSuperview().inset(24)
            $0.height.equalTo(Constants.Frame.textFieldHeight)
        }
        
        nextButton.snp.makeConstraints {
            $0.top.equalTo(birthTextField.snp.bottom).offset(22)
            $0.leading.trailing.equalToSuperview().inset(24)
            $0.height.equalTo(Constants.Frame.buttonHeight)
        }
    }
}
