//
//  TestCell.swift
//  SeSACgram
//
//  Created by hoon on 12/6/23.
//

import UIKit

final class TestCell: BaseCollectionViewCell {
    
    
    override var description: String {
        return String(describing: Self.self)
    }
    
    override func configureView() {
        self.backgroundColor = UIColor.green
    }
    
    override func setConstraints() {
        
    }
}
