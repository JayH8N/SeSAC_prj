//
//  GenderView.swift
//  Media
//
//  Created by hoon on 2023/08/29.
//

import UIKit


class GenderView: BaseView {
    
    
    
    let pickerView = UIPickerView()
    
    let doneButton = {
       let button = UIButton()
        button.setTitle("확인", for: .normal)
        button.setTitleColor(UIColor.red, for: .normal)
        return button
    }()
    
    
    override func configureView() {
        addSubview(pickerView)
        addSubview(doneButton)
    }
    
    override func setConstraints() {
        pickerView.snp.makeConstraints { make in
            make.center.equalTo(self)
            make.size.equalTo(self.snp.width).multipliedBy(0.6)
        }
        
        doneButton.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(pickerView.snp.bottom).offset(10)
        }
    }
}
