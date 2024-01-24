//
//  HighlightedButton.swift
//  SeSACgram
//
//  Created by hoon on 11/27/23.
//

import UIKit

class HighlightedButton: UIButton {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        layer.cornerRadius = self.frame.width / 2
    }
    
    func setView() {
        setBackgroundColor(.clear, for: .normal)
        setBackgroundColor(.gray.withAlphaComponent(0.4), for: .highlighted)
        tintColor = .black
        adjustsImageWhenHighlighted = false
        layer.masksToBounds = true
    }
}
