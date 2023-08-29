//
//  LinkView.swift
//  Media
//
//  Created by hoon on 2023/08/29.
//

import UIKit


class LinkView: BaseView {
    
    let textField = {
       let view = UITextField()
        view.placeholder = "Link"
        view.tintColor = .red
        view.layer.borderColor = UIColor.black.cgColor
        view.layer.borderWidth = 0.3
        return view
    }()
    
    
    
    
    override func configureView() {
        addSubview(textField)
    }
    
    
    
    override func setConstraints() {
        textField.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(self.safeAreaLayoutGuide).offset(10)
            make.leading.trailing.equalToSuperview().inset(10)
            make.height.equalTo(50)
        }
    }
    
    
    
}
