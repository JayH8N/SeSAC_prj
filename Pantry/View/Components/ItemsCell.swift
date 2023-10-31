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
    
    let itemImage = UIImageView().then {
        $0.contentMode = .scaleAspectFill
        $0.layer.cornerRadius = 10
        $0.clipsToBounds = true
    }
    
    let itemTitle = MarqueeLabel().then {
        $0.font = .boldSystemFont(ofSize: 16)
    }
    
    let expiredLabel = UILabel().then {
        $0.textColor = .black
        $0.font = .boldSystemFont(ofSize: 16)
        $0.textAlignment = .center
        $0.text = "Expired"
        $0.isHidden = true
        $0.transform = CGAffineTransform(rotationAngle: CGFloat.pi / 4)
    }
    
    let storageStateView = UIView()
    
    let expDateLabel = UILabel().then {
        $0.font = .systemFont(ofSize: 13)
        $0.numberOfLines = 2
    }
    
    let progressView = UIProgressView().then {
        $0.progressViewStyle = .default
        $0.trackTintColor = .black
    }
    
    let notificationMark = UIImageView().then {
        $0.tintColor = .black
        $0.image = UIImage(systemName: "bell.fill")
    }
    
    
    override func layoutSubviews() {
        storageStateView.layer.cornerRadius = storageStateView.bounds.width / 2
        //
        progressView.layer.borderColor = UIColor.black.cgColor
        progressView.layer.borderWidth = 2
        progressView.layer.cornerRadius = progressView.bounds.height / 2
        progressView.layer.sublayers![1].cornerRadius = progressView.bounds.height / 2
        progressView.clipsToBounds = true
        progressView.subviews[1].clipsToBounds = true
    }
    
    
    override func configureView() {
        contentView.layer.cornerRadius = 17
        contentView.layer.masksToBounds = false
        
        contentView.addSubview(itemImage)
        itemImage.addSubview(expiredLabel)
        contentView.addSubview(itemTitle)
        contentView.addSubview(expDateLabel)
        contentView.addSubview(progressView)
        contentView.addSubview(notificationMark)
        
        itemImage.addSubview(storageStateView)
    }
    
    
    override func setConstraints() {
        itemImage.snp.makeConstraints {
            $0.size.equalTo(self.snp.height).multipliedBy(0.65)
            $0.top.equalTo(self.snp.top).inset(10)
            $0.leading.equalTo(self.snp.leading).inset(10)
        }
        
        expiredLabel.snp.makeConstraints {
            $0.center.equalToSuperview()
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
            $0.size.equalToSuperview().multipliedBy(0.2)
            $0.top.equalToSuperview().inset(5)
            $0.trailing.equalToSuperview().inset(5)
        }
        
        progressView.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview().inset(10)
            $0.height.equalTo(10)
            $0.top.equalTo(itemImage.snp.bottom).offset(6)
        }
        
        notificationMark.snp.makeConstraints {
            $0.size.equalTo(itemImage).multipliedBy(0.4)
            $0.top.equalTo(self.snp.top).inset(-7)
            $0.leading.equalTo(self.snp.leading).inset(-7)
        }
    }
}

extension ItemsCell {
    func setCell(data: Items) {
        itemTitle.text = data.name
        itemImage.image = DocumentManager.shared.loadImageFromDocument(fileName: "JH\(data._id)")
        
        if data.state == 0 {
            storageStateView.backgroundColor = UIColor(red: 111/255, green: 178/255, blue: 232/255, alpha: 1)
            checkNotification(data: "\(data._id)", object: notificationMark)
        } else {
            storageStateView.backgroundColor = .blue
            notificationMark.isHidden = true
        }
        
        expDateLabel.text = "Exp.\n\(formatDate(date: data.expiryDay))"
        
        let percentage = calculateDiscount(expirationDate: data.expiryDay)
        if percentage >= 1.0 {
            expDateLabel.textColor = .black
            expiredLabel.isHidden = false
            contentView.backgroundColor = .darkGray.withAlphaComponent(0.9)
        } else {
            expDateLabel.textColor = UIColor.expColor
            expiredLabel.isHidden = true
            contentView.backgroundColor = .darkGray.withAlphaComponent(0.3)
        }
        
        progressView.setProgress(percentage, animated: false)
        
        
        
    }
}

extension ItemsCell {
    
    //프로그레스 뷰 계산
    func calculateDiscount(expirationDate: Date) -> Float {
        let components = Calendar.current.dateComponents([.year, .month, .day], from: expirationDate)
        
        let expDate = Calendar.current.date(from: components)!
     
        
        let offsetComps = Calendar.current.dateComponents([.day], from: Date(), to: expDate)
        
        if let day = offsetComps.day {
            switch day {
            case 0...3:
                progressView.tintColor = UIColor.freshBad
                return 0.85
            case 4...10:
                progressView.tintColor = UIColor.freshNotBad
                return 0.6
            case 11...:
                progressView.tintColor = UIColor.freshGood
                return 0.2
            default: //음수 => 유통기한 초과
                progressView.tintColor = UIColor.freshDone
                return 1.0
            }
        }
        return 0.0
    }
    
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
    
    
}
