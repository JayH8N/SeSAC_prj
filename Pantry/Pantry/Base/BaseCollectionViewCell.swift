//
//  BaseCollectionViewCell.swift
//  Pantry
//
//  Created by hoon on 2023/10/04.
//

import UIKit


class BaseCollectionViewCell: UICollectionViewCell {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        configureView()
        setConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    func configureView() { }
    
    func setConstraints() { }
    
    func checkNotification(data: String, object: UIImageView) {
        let notificationInfo = LocalNotificationManager.shared.readAlarmInfo(identifier: data)
        switch notificationInfo {
        case .none: object.isHidden = true
        case .oneDayBefore: object.isHidden = false
        case .threeDayBefore: object.isHidden = false
        case .sevenDayBefore: object.isHidden = false
        }
    }
    
}
