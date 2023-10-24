//
//  CustomRadioButton.swift
//  Pantry
//
//  Created by hoon on 2023/10/19.
//

import UIKit
import SnapKit
import Then

class CustomRadioButton: BaseView {
    
    var isSelected: Bool = false {
        didSet {
            update()
        }
    }
    
    let titleLabel = UILabel().then {
        $0.textAlignment = .left
    }
    let indicator = UIImageView().then {
        $0.tintColor = .black
    }

    
    
    override func configureView() {
        isSelected = false
        update()
        addSubview(titleLabel)
        addSubview(indicator)
    }
    
    override func layoutSubviews() {
        self.layer.cornerRadius = 10
    }
    
    override func setConstraints() {
        indicator.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.leading.equalToSuperview().inset(14)
            $0.size.equalTo(18)
        }
        
        titleLabel.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.leading.equalTo(indicator.snp.trailing).offset(20)
            $0.width.equalTo(250)
        }
    }
    
    func update() {
        if isSelected {
            
            titleLabel.textColor = UIColor.black
            indicator.image = UIImage(systemName: "record.circle")
            
            UIView.animate(withDuration: 0.1) {
                self.backgroundColor = UIColor.lightGray.withAlphaComponent(0.8)
            }
        } else {
            
            titleLabel.textColor = UIColor.black
            indicator.image = UIImage(systemName: "circle")
            
            UIView.animate(withDuration: 0.1) {
                self.backgroundColor = UIColor.clear
            }
        }
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        isSelected.toggle()
    }
    
}
