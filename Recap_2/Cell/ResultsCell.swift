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
    
    func setCell(data: Item) {
        let url = data.image
        
        if let url = URL(string: url) {
            itemImage.kf.setImage(with: url)
        }
        
        let titleResult = data.title.replacingOccurrences(of: "</b>", with: "").replacingOccurrences(of: "<b>", with: "")
        mallNameLabel.text = "[\(data.mallName)]"
        titleLabel.text = titleResult
        priceLabel.text = decimalWon(value: Int(data.lprice)!)
    }
    
    
    
    override func configureView() {
        contentView.backgroundColor = .clear
        let objects: [Any] = [itemImage, mallNameLabel, titleLabel, priceLabel]
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
    }
    
    
}
