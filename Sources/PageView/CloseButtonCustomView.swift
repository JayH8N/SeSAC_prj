//
//  CloseButtonCustomView.swift
//  Media
//
//  Created by hoon on 2023/08/25.
//

import UIKit


class CloseButtonCustomView: UIButton {
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    func setView() {
        tintColor = .black
        layer.borderColor = UIColor.black.cgColor
        layer.borderWidth = 3
    }
}
