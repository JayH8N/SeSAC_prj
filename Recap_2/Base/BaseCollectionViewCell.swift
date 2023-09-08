//
//  BaseCollectionViewCell.swift
//  Recap_2
//
//  Created by hoon on 2023/09/07.
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
    
    
    func changeState(_ object: UILabel, bgColor: UIColor, txtColor: UIColor, bdColor: CGColor) {
        object.backgroundColor = bgColor
        object.textColor = txtColor
        object.layer.borderColor = bdColor
    }
    
    //원단위 함수
    func decimalWon(value: Int) -> String{
        let numberFormatter = NumberFormatter()
        numberFormatter.numberStyle = .decimal
        let result = numberFormatter.string(from: NSNumber(value: value))!
        
        return result
    }
    
}
