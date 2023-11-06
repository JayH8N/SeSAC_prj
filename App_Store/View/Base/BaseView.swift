//
//  BaseView.swift
//  App_Store
//
//  Created by hoon on 11/6/23.
//

import UIKit

class BaseView: UIView {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureView()
        setConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configureView() {
        view.backgroundColor = .white
    }
    
    func setConstraints() { }
    
    
}
