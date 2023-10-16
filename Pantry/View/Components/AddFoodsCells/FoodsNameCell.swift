//
//  FoodsNameCell.swift
//  Pantry
//
//  Created by hoon on 2023/10/14.
//

import UIKit
import SnapKit
import Then

class FoodsNameCell: BaseTableViewCell {
    
    let foodName = NSLocalizedString("FoodName", comment: "")
    
    lazy var nameTextField = UITextField().then {
        $0.placeholder = foodName
        $0.tintColor = .black
    }
    
    
    
    override func configureView() {
        selectionStyle = .none
        contentView.addSubview(nameTextField)
    }
    
    
    
    override func setConstraints() {
        nameTextField.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview().inset(15)
            $0.centerY.equalToSuperview()
        }
    }
}
