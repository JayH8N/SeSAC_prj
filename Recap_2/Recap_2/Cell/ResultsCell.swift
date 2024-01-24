//
//  ResultsCell.swift
//  Recap_2
//
//  Created by hoon on 2023/09/08.
//

import UIKit
import Kingfisher


final class ResultsCell: BaseCollectionViewCell {
    
    let itemImage = ItemImageCustom(frame: .zero)
    let repository = NaverShoppingRepository()
    
    let mallNameLabel = {
        let view = UILabel()
        view.textColor = .lightGray
        view.font = .systemFont(ofSize: 12)
        return view
    }()
    
    let titleLabel = {
        let view = UILabel()
        view.textColor = .white
        view.font = .systemFont(ofSize: 15)
        view.numberOfLines = 2
        return view
    }()
    
    let priceLabel = {
        let view = UILabel()
        view.textColor = .white
        view.font = .boldSystemFont(ofSize: 18)
        return view
    }()
    
    
    let likeButton = {
        let uibutton = UIButton()
        uibutton.tintColor = .black
        return uibutton
    }()
    
    let buttonBackground = LikeButtonCustomView()
    
    
    
    func setCell(data: Item) {
        let url = data.image
        
        if let url = URL(string: url) {
            itemImage.kf.setImage(with: url, options: [.processor(ResizingImageProcessor(referenceSize: CGSize(width: 300, height: 300)))])
        }
        

        mallNameLabel.text = "[\(data.mallName)]"
        titleLabel.text = removeTag(data.title)
        priceLabel.text = decimalWon(value: Int(data.lprice)!)
        
        
        //DB에 존재하면 heart.fill 아니라면 heart
        if repository.isLikeFilter(data: data.productId) != nil {
            likeButton.setButtonImage(size: 30, systemName: "heart.fill")
        } else {
            likeButton.setButtonImage(size: 30, systemName: "heart")
        }
        
    }
    
    
    func likeCell(data: Items) {
        mallNameLabel.text = "[\(data.mallName)]"
        titleLabel.text = removeTag(data.title)
        priceLabel.text = decimalWon(value: Int(data.lprice)!)
        itemImage.image = DocumentManager.shared.loadImageFromDocument(fileName: "JH\(data.productId)")
    }
    
    
    
    
    
    override func configureView() {
        contentView.backgroundColor = .clear
        itemImage.isUserInteractionEnabled = true
        let objects: [Any] = [itemImage, mallNameLabel, titleLabel, priceLabel, buttonBackground, likeButton]
        for i in objects {
            contentView.addSubview(i as! UIView)
        }
        
    }
    
    
    override func setConstraints() {
        itemImage.snp.makeConstraints {
            $0.top.leading.trailing.equalToSuperview()
            $0.height.equalTo(itemImage.snp.width).multipliedBy(1)
        }
        
        mallNameLabel.snp.makeConstraints {
            $0.top.equalTo(itemImage.snp.bottom).offset(4)
            $0.leading.trailing.equalToSuperview().inset(5)
        }
        
        titleLabel.snp.makeConstraints {
            $0.top.equalTo(mallNameLabel.snp.bottom).offset(2)
            $0.leading.trailing.equalToSuperview().inset(5)
        }
        
        priceLabel.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom).offset(2)
            $0.leading.trailing.equalToSuperview().inset(5)
        }
        
        buttonBackground.snp.makeConstraints {
            $0.size.equalTo(40)
            $0.trailing.equalTo(contentView.snp.trailing).inset(6)
            $0.centerY.equalTo(contentView).multipliedBy(1.16)
        }
        
        likeButton.snp.makeConstraints {
            $0.center.equalTo(buttonBackground)
        }
    }
    
    
}

