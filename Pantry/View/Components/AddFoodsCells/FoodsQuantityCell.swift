//
//  FoodsQuantityCell.swift
//  Pantry
//
//  Created by hoon on 2023/10/16.
//

import UIKit
import Then
import SnapKit

class FoodsQuantityCell: BaseTableViewCell {
    
    var quantityNum = 1
    
    let stepper = UIStepper().then {
        $0.addTarget(self, action: #selector(stepperValueChanged), for: .valueChanged)
        $0.minimumValue = 1
        $0.maximumValue = 100
    }
    
    let qLabel = UILabel().then {
        $0.font = .boldSystemFont(ofSize: 30)
        $0.textAlignment = .center
        $0.text = String(1)
    }
    
    
    
    
    
    
    
    override func configureView() {
        selectionStyle = .none
        textLabel?.text = NSLocalizedString("Quantity", comment: "")
        
        contentView.addSubview(stepper)
        contentView.addSubview(qLabel)
        
    }
    
    
    override func setConstraints() {
        
        stepper.snp.makeConstraints {
            $0.centerY.equalToSuperview()
        }
        
        qLabel.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.size.equalTo(contentView.snp.height).multipliedBy(1)
            $0.leading.equalTo(stepper.snp.trailing).offset(10)
            $0.trailing.equalToSuperview().inset(10)
        }
    }
    
    
}

extension FoodsQuantityCell {
    
    @objc private func stepperValueChanged() {
        qLabel.text = String(Int(stepper.value))
        quantityNum = Int(stepper.value)
    }
}
