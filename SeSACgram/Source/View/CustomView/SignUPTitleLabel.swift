//
//  SignUPTitleLabel.swift
//  SeSACgram
//
//  Created by hoon on 11/19/23.
//

import UIKit

class SignUPTitleLabel: UILabel {
    
    init(title: String) {
        super.init(frame: .zero)
     
        self.text = title
        self.font = Constants.Font.HeaderTitle
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
