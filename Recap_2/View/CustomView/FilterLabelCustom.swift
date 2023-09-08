//
//  FilterCustom.swift
//  Recap_2
//
//  Created by hoon on 2023/09/08.
//

import UIKit

class FilterLabelCustom: UILabel {
    
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    func setView() {
        layer.cornerRadius = 8
        layer.borderColor = CustomColor.feildItemColor.cgColor
        layer.borderWidth = 1
        clipsToBounds = true
        textAlignment = .center
        backgroundColor = .clear
        textColor = CustomColor.feildItemColor
        font = .systemFont(ofSize: 14)
    }
}
