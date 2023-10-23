//
//  ItemsCell.swift
//  Pantry
//
//  Created by hoon on 2023/10/10.
//

import UIKit
import SnapKit
import Then
import MarqueeLabel

class ItemsCell: BaseCollectionViewCell {
    
    let blurEffect = UIVisualEffectView(effect: UIBlurEffect(style: .light))
    
    let itemImage = UIImageView().then {
        $0.contentMode = .scaleAspectFill
        $0.layer.cornerRadius = 10
        $0.clipsToBounds = true
    }
    
    let itemTitle = MarqueeLabel().then {
        $0.font = .boldSystemFont(ofSize: 16)
    }
    
    let storageStateView = UIView()
    
    let expDateLabel = UILabel().then {
        $0.font = .systemFont(ofSize: 13)
        $0.textColor = .red
        $0.numberOfLines = 2
    }
    
    let progressView = UIProgressView().then {
        $0.progressViewStyle = .default
        $0.trackTintColor = .black
    }
    
    
    override func layoutSubviews() {
        storageStateView.layer.cornerRadius = storageStateView.bounds.width / 2
        //
        progressView.layer.borderColor = UIColor.black.cgColor
        progressView.layer.borderWidth = 4
        progressView.layer.cornerRadius = progressView.bounds.height / 2
        progressView.layer.sublayers![1].cornerRadius = progressView.bounds.height / 2
        progressView.clipsToBounds = true
        progressView.subviews[1].clipsToBounds = true
    }
    
    
    override func configureView() {
        contentView.backgroundColor = .black.withAlphaComponent(0.5)
        contentView.addSubview(blurEffect)
        contentView.layer.cornerRadius = 17
        contentView.layer.masksToBounds = true
        
        contentView.addSubview(itemImage)
        contentView.addSubview(itemTitle)
        contentView.addSubview(expDateLabel)
        contentView.addSubview(progressView)
        
        itemImage.addSubview(storageStateView)
    }
    
    
    override func setConstraints() {
        blurEffect.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
        itemImage.snp.makeConstraints {
            $0.size.equalTo(self.snp.height).multipliedBy(0.5)
            $0.top.equalTo(self.snp.top).inset(10)
            $0.leading.equalTo(self.snp.leading).inset(10)
        }
        
        itemTitle.snp.makeConstraints {
            $0.top.equalTo(self.snp.top).inset(10)
            $0.leading.equalTo(itemImage.snp.trailing).offset(6)
            $0.trailing.equalTo(self.snp.trailing).inset(6)
        }
        
        expDateLabel.snp.makeConstraints {
            $0.top.equalTo(itemTitle.snp.bottom).offset(3)
            $0.leading.equalTo(itemImage.snp.trailing).offset(6)
            $0.trailing.equalTo(self.snp.trailing).inset(6)
        }
        
        storageStateView.snp.makeConstraints {
            $0.size.equalToSuperview().multipliedBy(0.25)
            $0.top.equalToSuperview().inset(5)
            $0.trailing.equalToSuperview().inset(5)
        }
        
        progressView.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview().inset(10)
            $0.height.equalTo(16)
            $0.top.equalTo(itemImage.snp.bottom).offset(14)
        }
    }
}

extension ItemsCell {
    func setCell(data: Items) {
        itemTitle.text = data.name
        itemImage.image = DocumentManager.shared.loadImageFromDocument(fileName: "JH\(data._id)")
        
        if data.state == 0 {
            storageStateView.backgroundColor = UIColor(red: 111/255, green: 178/255, blue: 232/255, alpha: 1)
        } else {
            storageStateView.backgroundColor = .blue
        }
        
        expDateLabel.text = "Exp.\n\(formatDate(date: data.expiryDay))"
        
        let percentage = calculateDiscount(expirationDate: data.expiryDay)
        
        progressView.setProgress(percentage, animated: false)
    }
}

extension ItemsCell {
    
    //날짜형식 변환
    func formatDate(date: Date) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.timeZone = TimeZone.current

        if Locale.preferredLanguages.first == "en-US" {
            dateFormatter.dateFormat = "MM-dd-yyyy"
            dateFormatter.locale = Locale(identifier: "en_US")
        } else {
            dateFormatter.dateFormat = "yyyy-MM-dd"
            dateFormatter.locale = Locale(identifier: "ko_KR")
        }

        return dateFormatter.string(from: date)
    }
    
    //프로그레스 뷰 계산
    func calculateDiscount(expirationDate: Date) -> Float {
        let components = Calendar.current.dateComponents([.year, .month, .day], from: expirationDate)
        let startDate = Calendar.current.date(from: components)!
        
        let offsetComps = Calendar.current.dateComponents([.day], from: Date(), to: startDate)
        
        if let day = offsetComps.day {
            switch day {
            case 0...3:
                progressView.tintColor = .red
                return 0.8
            case 4...10:
                progressView.tintColor = .yellow
                return 0.5
            case 11...:
                progressView.tintColor = .green
                return 0.3
            default:
                progressView.tintColor = .purple
                return 1.0
            }
        }
        
        return 0.0
    }
}
