//
//  InfoView.swift
//  Media
//
//  Created by hoon on 2023/08/29.
//

import UIKit

class InfoView: BaseView {
    
    let textView = {
        let view = UITextView()
        view.layer.borderColor = UIColor.black.cgColor
        view.layer.borderWidth = 0.3
        return view
    }()
    
    
    
    
    override func configureView() {
       addSubview(textView)
    }
    
    
    
    override func setConstraints() {
        textView.snp.makeConstraints { make in
            make.top.equalTo(self.safeAreaLayoutGuide).offset(10)
            make.leading.trailing.equalToSuperview().inset(10)
            make.height.equalTo(self.snp.height).multipliedBy(0.4)
        }
    }
}
