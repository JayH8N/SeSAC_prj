//
//  BottomSheetView.swift
//  SeSACgram
//
//  Created by hoon on 11/27/23.
//

import UIKit
import SnapKit
import Then

final class BottomSheetView: BaseView {
    
    private let modalView = UIView().then {
        $0.backgroundColor = Constants.Color.AppearanceModal
        $0.layer.cornerRadius = 20
        $0.isUserInteractionEnabled = true
    }
    
    let settingAndPersonalMenu = MenuListButtonView(iconImage: Constants.Image.Gear,
                                                    text: "설정 및 개인정보")
    
    override func configureView() {
        self.backgroundColor = .clear
        addSubview(modalView)
        modalView.addSubview(settingAndPersonalMenu)
    }
    
    override func setConstraints() {
        modalView.snp.makeConstraints {
            $0.center.equalToSuperview()
            $0.leading.trailing.equalToSuperview().inset(20)
            $0.height.equalTo(150)
        }
        
        settingAndPersonalMenu.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.leading.trailing.equalToSuperview()
            $0.height.equalTo(Constants.Frame.menuListHeight)
        }
    }
}
