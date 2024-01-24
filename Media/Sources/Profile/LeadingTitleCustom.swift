//
//  LeadingTitleCustom.swift
//  Media
//
//  Created by hoon on 2023/08/29.
//

import UIKit

class LeadingTitle: UILabel {
    
    
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    
    func setView() {
        font = .boldSystemFont(ofSize: 16)
    }
    
    
    
    
}
