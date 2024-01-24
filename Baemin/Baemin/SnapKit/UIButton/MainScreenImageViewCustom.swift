//
//  MainScreenImageViewCustom.swift
//  Baemin
//
//  Created by hoon on 2023/08/27.
//

import UIKit


class MainScreenImageViewCustom: UIImageView {
    
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setView()
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    
    func setView() {
        layer.borderColor = UIColor.black.cgColor
        layer.borderWidth = 3
    }
    
    
    override func layoutSubviews() {
        layer.cornerRadius = 10
    }
}
