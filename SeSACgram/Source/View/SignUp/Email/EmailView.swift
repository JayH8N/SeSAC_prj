//
//  EmailView.swift
//  SeSACgram
//
//  Created by hoon on 11/15/23.
//

import UIKit
import Then
import SnapKit

class EmailView: BaseView {
    
    let titleLabel = SignUPTitleLabel(title: "E-Mail 입력")
    
    
    
    override func configureView() {
        addSubview(titleLabel)
    }
    
    override func setConstraints() {
        titleLabel.snp.makeConstraints {
            $0.leading.equalToSuperview().inset(24)
            $0.top.equalTo(self.safeAreaLayoutGuide).inset(20)
        }
    }
    
    
}
