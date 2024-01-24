//
//  FilterCollectionViewCell.swift
//  Recap_2
//
//  Created by hoon on 2023/09/08.
//

import UIKit

final class FilterCell: BaseCollectionViewCell {
    
    let filterLabel = FilterLabelCustom()
    
    override var isSelected: Bool {
        didSet {
            if isSelected {
                changeState(filterLabel, bgColor: .white, txtColor: .black, bdColor: UIColor.white.cgColor)
            } else {
                changeState(filterLabel, bgColor: .clear, txtColor: CustomColor.feildItemColor, bdColor: CustomColor.feildItemColor.cgColor)
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
