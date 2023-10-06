//
//  BaseCollectionViewCell.swift
//  Pantry
//
//  Created by hoon on 2023/10/04.
//

import UIKit


class BaseCollectionViewCell: UICollectionViewCell {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        configureView()
        setConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    func configureView() { }
    
    func setConstraints() { }
    
}
