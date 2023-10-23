//
//  SearchItemCell.swift
//  Pantry
//
//  Created by hoon on 2023/10/23.
//

import UIKit
import SnapKit
import Then
import MarqueeLabel

class SearchItemCell: BaseCollectionViewCell {
    
    let blurEffect = UIVisualEffectView(effect: UIBlurEffect(style: .light))
    
    let imageBackView = UIView().then {
        $0.backgroundColor = .clear
    }
    
    let imageView = UIImageView().then {
        $0.contentMode = .scaleAspectFill
        $0.layer.cornerRadius = 10
        $0.clipsToBounds = true
        $0.backgroundColor = .black
    }
    
    let storageStateView = UIView()
    
    let itemTitle = MarqueeLabel().then {
        $0.font = .boldSystemFont(ofSize: 16)
        $0.textAlignment = .center
        $0.text = "item Name"
    }
    
    let storageImage = UIImageView().then {
        $0.image = UIImage(systemName: "archivebox")
        $0.tintColor = .black
    }
    let storageTitle = UILabel().then {
        $0.font = .systemFont(ofSize: 16)
        $0.textAlignment = .center
    }
    
    lazy var storageStackView = UIStackView(arrangedSubviews: [storageImage, storageTitle]).then {
        $0.axis = .horizontal
        $0.spacing = 3
    }
    
    let expLabel = UILabel().then {
        $0.font = .systemFont(ofSize: 12)
        $0.textAlignment = .center
    }
    
    
    override func layoutSubviews() {
        storageStateView.layer.cornerRadius = 7
    }
    
    override func configureView() {
        contentView.backgroundColor = .black.withAlphaComponent(0.5)
        contentView.addSubview(blurEffect)
        contentView.layer.cornerRadius = 10
        contentView.layer.masksToBounds = true
        contentView.addSubview(imageBackView)
        imageBackView.addSubview(imageView)
        imageView.addSubview(storageStateView)
        contentView.addSubview(itemTitle)
        contentView.addSubview(storageStackView)
        contentView.addSubview(expLabel)
    }
    
    
    
    override func setConstraints() {
        blurEffect.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
        imageBackView.snp.makeConstraints {
            $0.top.leading.trailing.equalToSuperview()
            $0.height.equalTo(contentView.snp.width).multipliedBy(1)
        }
        
        imageView.snp.makeConstraints {
            $0.edges.equalToSuperview().inset(4)
        }
        
        storageStateView.backgroundColor = .white
        storageStateView.snp.makeConstraints {
            $0.size.equalToSuperview().multipliedBy(0.14)
            $0.top.equalToSuperview().inset(8)
            $0.trailing.equalToSuperview().inset(5)
        }
        
        itemTitle.snp.makeConstraints {
            $0.top.equalTo(imageBackView.snp.bottom)
            $0.leading.equalTo(contentView.snp.leading).inset(8)
            $0.trailing.equalTo(contentView.snp.trailing).inset(8)
        }
        
        storageStackView.snp.makeConstraints {
            $0.height.equalTo(itemTitle.snp.height)
            $0.leading.trailing.equalTo(itemTitle)
            $0.top.equalTo(itemTitle.snp.bottom).offset(2)
        }
        
        storageImage.snp.makeConstraints {
            $0.height.equalTo(storageStackView.snp.height)
            $0.width.equalTo(storageImage.snp.height)
        }
        
        expLabel.snp.makeConstraints {
            $0.top.equalTo(storageStackView.snp.bottom)
            $0.bottom.equalTo(contentView.snp.bottom)
            $0.leading.trailing.equalTo(storageStackView)
        }
        
        
        
    }
    
    func calculateExpiryStatus(expDay: Date) -> String {
        let timeInterval = expDay.timeIntervalSince(Date())
        
        let remainDay = Int(timeInterval / 60 / 60 / 24)
        
        if remainDay >= 0 {
            expLabel.textColor = .red
            return String(format: NSLocalizedString("EXPLeft", comment: ""), remainDay)
        } else {
            expLabel.textColor = .black
            return String(format: NSLocalizedString("EXPAgo", comment: ""), (-1 * remainDay))
        }
    }
    
    
}

extension SearchItemCell {
    func setCell(data: Items) {
        itemTitle.text = data.name
        imageView.image = DocumentManager.shared.loadImageFromDocument(fileName: "JH\(data._id)")
        
        if data.state == 0 {
            storageStateView.backgroundColor = UIColor(red: 111/255, green: 178/255, blue: 232/255, alpha: 1)
        } else {
            storageStateView.backgroundColor = .blue
        }
        
        //storageTitle.text = data.mainFridge
        storageTitle.text = data.mainFridge.first?.name
        expLabel.text = calculateExpiryStatus(expDay: data.expiryDay)
    }
}
