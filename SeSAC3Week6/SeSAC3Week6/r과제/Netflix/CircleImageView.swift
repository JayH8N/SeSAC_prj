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
        let randomRed = CGFloat.random(in: 0...1)
        let randomGreen = CGFloat.random(in: 0...1)
        let randomBlue = CGFloat.random(in: 0...1)

        let randomColor = UIColor(red: randomRed, green: randomGreen, blue: randomBlue, alpha: 1)
        
        layer.borderColor = randomColor.cgColor
        layer.borderWidth = 3
        clipsToBounds = true
        contentMode = .scaleAspectFill
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        layer.cornerRadius = frame.width / 2
    }
    
}
