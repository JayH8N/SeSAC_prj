//
//  ItemImageCustomView.swift
//  Recap_2
//
//  Created by hoon on 2023/09/08.
//

import UIKit


class ItemImageCustom: UIImageView {
    
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    func setView() {
        clipsToBounds = true
        contentMode = .scaleAspectFill
    }
    
    
    override func layoutSublayers(of layer: CALayer) {
        layer.cornerRadius = 7
        
    }
    
    
}
