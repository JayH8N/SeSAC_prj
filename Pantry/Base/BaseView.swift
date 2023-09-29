//
//  BaseView.swift
//  Pantry
//
//  Created by hoon on 2023/09/25.
//

import UIKit

class BaseView: UIView {
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        configureView()
        setConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    
    func configureView() {
        self.backgroundColor = UIColor.natural
    }
    
    func setConstraints() { }
    
    
    
}
