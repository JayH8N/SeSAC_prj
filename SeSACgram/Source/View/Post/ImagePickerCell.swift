//
//  ImagePickerCell.swift
//  SeSACgram
//
//  Created by hoon on 12/1/23.
//

import UIKit
import SnapKit
import SnapKit

class ImagePickerCell: BaseCollectionViewCell {
    
    private let imageView = UIImageView().then {
        $0.contentMode = .scaleAspectFill
        $0.image = Constants.Image.Camera
        $0.tintColor = .lightGray
    }
    
    private let countLabel = UILabel().then {
        $0.text = "0/4"
        $0.textColor = .lightGray
    } 
    
    
    override var description: String {
        String(describing: Self.self)
    }
    
    private func setLayer() {
        layer.masksToBounds = true
        layer.cornerRadius = Constants.Size.cellCornerRadius
        layer.borderWidth = 3
        layer.borderColor = UIColor.lightGray.cgColor
    }
    
    override func configureView() {
        setLayer()
        contentView.addSubview(imageView)
        contentView.addSubview(countLabel)
    }
    
    override func setConstraints() {
        imageView.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.centerY.equalToSuperview().multipliedBy(0.7)
            $0.size.equalToSuperview().multipliedBy(0.3)
        }
        countLabel.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.top.equalTo(imageView.snp.bottom).offset(10)
        }
    }
    
    
}
