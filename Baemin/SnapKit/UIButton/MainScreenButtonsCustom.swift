//
//  MainScreenButtonsCustom.swift
//  Baemin
//
//  Created by hoon on 2023/08/26.
//

import UIKit

class MainScreenButtonsCustom: UIButton {
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    
    func setView() {
        clipsToBounds = true
        layer.borderColor = UIColor.black.cgColor
        layer.borderWidth = 3
        layer.cornerRadius = 10
    }
    
    
}
