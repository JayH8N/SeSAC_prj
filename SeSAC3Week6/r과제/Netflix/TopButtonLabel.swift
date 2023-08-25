//
//  TopButtonLabel.swift
//  SeSAC3Week6
//
//  Created by hoon on 2023/08/25.
//

import UIKit

class TopButtonLabel: UILabel {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    
    
    func setUpView() {
        textColor = .white
        numberOfLines = 1
        font = .boldSystemFont(ofSize: 15)
    }
    
    
    
    
}
