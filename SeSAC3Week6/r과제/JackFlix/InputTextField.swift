//
//  InputTextField.swift
//  SeSAC3Week6
//
//  Created by hoon on 2023/08/24.
//

import UIKit


class InputTextField: UITextField {
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    
    func setupView() {
        layer.cornerRadius = 5
        backgroundColor = .lightGray
        textColor = .white
        textAlignment = .center
        font = .systemFont(ofSize: 16)
        attributedPlaceholder = NSAttributedString(string: "placeholder Color", attributes: [NSAttributedString.Key.foregroundColor : UIColor.white])
    }
}
