//
//  ActionButton.swift
//  SeSAC_Talk
//
//  Created by hoon on 1/8/24.
//

import UIKit

final class ActionButton: UIButton {
    
    init(enalble: Bool, text: String) {
        super.init(frame: .zero)
        setUI(enable: enalble)
        self.setTitle(text, for: .normal)
    }
    
    private func setUI(enable: Bool) {
        self.titleLabel?.font = Constants.Typography.Title2
        if enable {
            backgroundColor = Constants.Color.Brand.Green
            self.isEnabled = true
        } else {
            backgroundColor = Constants.Color.Brand.Inactive
            self.isEnabled = false
        }
        self.layer.cornerRadius = 8
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
}
