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
        $0.backgroundColor = .black
    }
    
    let itemTitle = MarqueeLabel().then {
        $0.font = .boldSystemFont(ofSize: 16)
        $0.text = "Item Name"
    }
    
    let storageStateView = UIView()
    
    let expDateLabel = UILabel().then {
        $0.font = .systemFont(ofSize: 13)
        $0.textColor = .red
        $0.text = "Exp.\n0000-00-00"
        $0.numberOfLines = 2
    }
    
    let progressView = UIProgressView().then {
        $0.progressViewStyle = .default
        $0.progressTintColor = .green
        $0.trackTintColor = .black
    }
    
    
    override func layoutSubviews() {
        storageStateView.layer.borderWidth = 1
        storageStateView.layer.borderColor = UIColor.white.cgColor
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
            $0.bottom.equalTo(itemImage.snp.bottom)
        }
        
        progressView.setProgress(1.0, animated: true)
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
            storageStateView.backgroundColor = .blue
        } else {
            storageStateView.backgroundColor = UIColor(red: 111/255, green: 178/255, blue: 232/255, alpha: 1)
        }
        
        expDateLabel.text = "Exp.\n\(formatDate(date: data.expiryDay))"
        let percentage = calculateProgressPercentage(currentDate: Date(), expirationDate: data.expiryDay)
        
        
        if percentage <= 0.35 {
            progressView.tintColor = .green
        } else if percentage <= 0.65 {
            progressView.tintColor = .yellow
        } else if percentage <= 0.99 {
            progressView.tintColor = .red
        } else {
            progressView.tintColor = .purple
        }
        progressView.setProgress(percentage, animated: true)
    }
}

extension ItemsCell {
    
    //날짜형식 변환
    func formatDate(date: Date) -> String {
        let dateFormatter = DateFormatter()
        let locale = Locale.current
        
        if locale.identifier == "en_US" {
            dateFormatter.dateFormat = "MM-dd-yyyy"
        } else {
            dateFormatter.dateFormat = "yyyy-MM-dd"
        }
        
        dateFormatter.timeZone = TimeZone.current
        return dateFormatter.string(from: date)
    }
    
    //프로그레스 뷰 계산
    func calculateProgressPercentage(currentDate: Date, expirationDate: Date) -> Float {
        // 현재 날짜와 유통기한 날짜 간격
        let calendar = Calendar.current
        let timeDifference = calendar.dateComponents([.day], from: currentDate, to: expirationDate)
        
        // 유통기한까지의 총 날짜
        let totalDays = Float(timeDifference.day ?? 0)
        
        // 현재 날짜부터 유통기한까지의 남은 날짜
        let remainingDays = Float(max(timeDifference.day ?? 0, 0))
        
        // 진행 퍼센트 계산
        let progressPercentage = remainingDays / totalDays
        
        // 유통기한이 지난 경우에는 1.0으로 설정
        if progressPercentage < 0 {
            return 1.0
        }
        
        return min(progressPercentage, 1.0)
    }

}
