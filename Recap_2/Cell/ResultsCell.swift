//
//  ResultsCell.swift
//  Recap_2
//
//  Created by hoon on 2023/09/08.
//

import UIKit
import Kingfisher


class ResultsCell: BaseCollectionViewCell {
    
    let itemImage = ItemImageCustom(frame: .zero)
    
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
//        let buttonImage = UIImage.SymbolConfiguration(pointSize: 30, weight: .light, scale: .small)
//        let image = UIImage(systemName: "heart", withConfiguration: buttonImage)
//        uibutton.setImage(image, for: .normal)
        uibutton.tintColor = .black
        return uibutton
    }()
    
    let buttonBack = LikeButtonCustomView()
    
//    var isTouched: Bool {
//        didSet {
//            if isTouched {
//                likeButton.setImage(UIImage(systemName: "heart.fill", withConfiguration: UIImage.SymbolConfiguration(pointSize: 30, weight: .light)), for: .normal)
//            } else {
//                likeButton.setImage(UIImage(systemName: "heart", withConfiguration: UIImage.SymbolConfiguration(pointSize: 30, weight: .light)), for: .normal)
//            }
//        }
//    }
    
    
    
    func setCell(data: Item) {
        let url = data.image
        
        if let url = URL(string: url) {
            itemImage.kf.setImage(with: url, options: [.processor(ResizingImageProcessor(referenceSize: CGSize(width: 300, height: 300)))])
        }
        

        mallNameLabel.text = "[\(data.mallName)]"
        titleLabel.text = removeTag(data.title)
        priceLabel.text = decimalWon(value: Int(data.lprice)!)
    }
    
    
    func likeCell(data: Items) {
        mallNameLabel.text = "[\(data.mallName)]"
        titleLabel.text = removeTag(data.title)
        priceLabel.text = decimalWon(value: Int(data.lprice)!)
        itemImage.image = DocumentManager.shared.loadImageFromDocument(fileName: "JH\(data._id)")
    }
    
    
    
    
    
    override func configureView() {
        contentView.backgroundColor = .clear
        itemImage.isUserInteractionEnabled = true
        let objects: [Any] = [itemImage, mallNameLabel, titleLabel, priceLabel, buttonBack, likeButton]
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
        
        buttonBack.snp.makeConstraints {
            $0.size.equalTo(40)
            $0.trailing.equalTo(contentView.snp.trailing).inset(6)
            $0.centerY.equalTo(contentView).multipliedBy(1.16)
        }
        
        likeButton.snp.makeConstraints {
            $0.center.equalTo(buttonBack)
        }
    }
    
    
}

