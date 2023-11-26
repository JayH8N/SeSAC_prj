//
//  ProfileView.swift
//  SeSACgram
//
//  Created by hoon on 11/14/23.
//

import UIKit

final class ProfileView: BaseView {
    
    let withdrawButton = UIButton.responsiveButton(title: "탈퇴", color: Constants.Color.DeepGreen , isEnable: true)
    
  
    
    override func configureView() {
        addSubview(withdrawButton)
    }
    
    override func setConstraints() {
        withdrawButton.snp.makeConstraints {
            $0.center.equalToSuperview()
            $0.width.equalTo(60)
            $0.height.equalTo(55)
        }
    }
    
    
    
}
