//
//  FoodsStateCell.swift
//  Pantry
//
//  Created by hoon on 2023/10/16.
//

import UIKit
import SnapKit
import Then


class FoodsStateCell: BaseTableViewCell {
    
    var selectedType = 0
    
    let items = [NSLocalizedString("Refrigerator", comment: ""), NSLocalizedString("Freezer", comment: "")]
    
    lazy var storageType = UISegmentedControl(items: items).then {
        $0.selectedSegmentIndex = 0
        $0.selectedSegmentTintColor = UIColor.refrigerCellBackground
        $0.addTarget(self, action: #selector(segmentedControlValueChanged), for: .valueChanged)
    }
    
    
    
    override func configureView() {
        selectionStyle = .none
        
        contentView.addSubview(storageType)
        
    }
    
    
    override func setConstraints() {
        storageType.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
    
}

extension FoodsStateCell {
    @objc private func segmentedControlValueChanged(_ sender: UISegmentedControl) {
        selectedType = sender.selectedSegmentIndex
    }
}
