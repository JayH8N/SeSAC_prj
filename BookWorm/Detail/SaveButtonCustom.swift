//
//  SaveButtonCustom.swift
//  BookWorm
//
//  Created by hoon on 2023/09/07.
//

import UIKit


class SaveButtonCustom: UIImageView {
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    
    func setView() {
        tintColor = .blue
    }
    
    override func layoutSublayers(of layer: CALayer) {
        layer.cornerRadius = bounds.size.width / 2
    }
}
