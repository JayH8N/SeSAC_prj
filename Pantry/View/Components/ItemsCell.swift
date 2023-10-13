//
//  ItemsCell.swift
//  Pantry
//
//  Created by hoon on 2023/10/10.
//

import UIKit
import SnapKit
import Then

class ItemsCell: BaseCollectionViewCell {
    
    let blurEffect = UIVisualEffectView(effect: UIBlurEffect(style: .light))
    
    let foodImage = UIImageView().then {
        $0.contentMode = .scaleAspectFill
        $0.layer.cornerRadius = 10
        $0.backgroundColor = .black
    }
    
    let foodTitle = UILabel().then {
        $0.font = .boldSystemFont(ofSize: 16)
        $0.text = "food Name"
    }
    
    

    
    
    override func configureView() {
        contentView.backgroundColor = .black.withAlphaComponent(0.5)
        contentView.addSubview(blurEffect)
        contentView.layer.cornerRadius = 25
        contentView.layer.masksToBounds = true
        
        contentView.addSubview(foodImage)
        contentView.addSubview(foodTitle)
    }
    
    
    override func setConstraints() {
        blurEffect.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
        foodImage.snp.makeConstraints {
            $0.size.equalTo(self.snp.height).multipliedBy(0.5)
            $0.top.equalTo(self.snp.top).inset(10)
            $0.leading.equalTo(self.snp.leading).inset(10)
        }
        
        foodTitle.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview().inset(12)
            $0.top.equalTo(foodImage.snp.bottom).offset(4)
            $0.bottom.equalTo(self.snp.bottom).inset(4)
        }
    }
}
