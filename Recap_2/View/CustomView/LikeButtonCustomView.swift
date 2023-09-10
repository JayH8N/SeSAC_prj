//
//  LikeButtonCustomView.swift
//  Recap_2
//
//  Created by hoon on 2023/09/10.
//

import UIKit

class LikeButtonCustomView: UIView {
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    
    func setView() {
        backgroundColor = .white
    }
    
    
    override func layoutSublayers(of layer: CALayer) {
        layer.cornerRadius = bounds.size.width / 2
    }
}
