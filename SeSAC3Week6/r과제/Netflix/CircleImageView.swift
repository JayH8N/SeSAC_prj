//
//  CircleImageView.swift
//  SeSAC3Week6
//
//  Created by hoon on 2023/08/25.
//

import UIKit


class CircleImageView: UIImageView {
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    
    func setupView() {
        layer.borderColor = UIColor(red: CGFloat(Int.random(in: 0...255)/255), green: CGFloat(Int.random(in: 0...255)/255), blue: CGFloat(Int.random(in: 0...255)/255), alpha: 1).cgColor
        layer.borderWidth = 2
        layer.cornerRadius = layer.frame.width/2
    }
    
}
