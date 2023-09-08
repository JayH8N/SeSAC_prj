//
//  FilterCollectionViewCell.swift
//  Recap_2
//
//  Created by hoon on 2023/09/08.
//

import UIKit

class FilterCell: BaseCollectionViewCell {
    
    let filterLabel = FilterCustomLabel()
    
    override var isSelected: Bool {
        didSet {
            if isSelected {
                filterLabel.backgroundColor = .white
                filterLabel.textColor = .black
            } else {
                filterLabel.backgroundColor = .clear
                filterLabel.textColor = CustomColor.feildItemColor
            }
        }
    }
    
    
    override func configureView() {
        contentView.addSubview(filterLabel)
    }
    
    
    override func setConstraints() {
        filterLabel.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
}
