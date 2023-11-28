//
//  MenuListButtonView.swift
//  SeSACgram
//
//  Created by hoon on 11/27/23.
//

import UIKit
import SnapKit
import Then

class MenuListButtonView: BaseView {
    
    let gradientLayer = CAGradientLayer()
    
    let iconImage = UIImageView().then {
        $0.tintColor = Constants.Color.AppearanceObject
    }
    let titleLabel = UILabel().then {
        $0.textAlignment = .left
        $0.font = Constants.Font.TypicalFont
    }
    
    init(iconImage: String, text: String) {
        super.init(frame: .zero)
        self.iconImage.image = UIImage(systemName: iconImage)
        self.titleLabel.text = text
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func configureView() {
        self.backgroundColor = Constants.Color.AppearanceModal
        addSubview(iconImage)
        addSubview(titleLabel)
        titleLabel.layer.addBorder([.bottom], width: 1.0, color: UIColor.yellow.cgColor)
    }
    
    override func setConstraints() {
        iconImage.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.leading.equalToSuperview().inset(12)
            $0.size.equalTo(self.snp.height).multipliedBy(0.8)
        }
        
        titleLabel.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.leading.equalTo(iconImage.snp.trailing).offset(20)
            $0.trailing.equalToSuperview()
            $0.bottom.equalToSuperview()
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        HapticManager.shared.viberateForInteraction(style: .light)
    }
}
