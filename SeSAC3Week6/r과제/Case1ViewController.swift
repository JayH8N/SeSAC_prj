//
//  Case1ViewController.swift
//  SeSAC3Week6
//
//  Created by hoon on 2023/08/22.
//

import UIKit
import SnapKit

class Case1ViewController: UIViewController {

    let imageView = UIImageView()
    let textField1 = textField(placeholder: "제목을 입력해주세요")
    let textField2 = textField(placeholder: "날짜를 입력해주세요")
    let textField3 = textField()
    
    static func textField(placeholder: String? = nil) -> UITextField {
        let textF = UITextField()
        textF.placeholder = placeholder
        textF.layer.borderWidth = 2
        textF.layer.borderColor = UIColor.black.cgColor
        textF.textAlignment = .center
        return textF
    }

    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        view.addSubview(imageView)
        view.addSubview(textField1)
        view.addSubview(textField2)
        view.addSubview(textField3)
        
        setImageView()
        setTextField1()
        setTextField2()
        setTextField3()
    }
    
    func setImageView() {
        imageView.backgroundColor = .lightGray
        imageView.snp.makeConstraints { make in
            make.top.equalTo(view)
            make.leadingMargin.equalTo(20)
            make.trailingMargin.equalTo(-20)
            make.height.equalTo(view).multipliedBy(0.35)
        }
    }
    
    func setTextField1() {
        textField1.snp.makeConstraints { make in
            make.height.equalTo(55)
            make.leadingMargin.equalTo(20)
            make.trailingMargin.equalTo(-20)
            make.top.equalTo(imageView.snp.bottom).offset(20)
        }
    }
    
    func setTextField2() {
        textField2.snp.makeConstraints { make in
            make.height.equalTo(55)
            make.leadingMargin.equalTo(20)
            make.trailingMargin.equalTo(-20)
            make.top.equalTo(textField1.snp.bottom).offset(20)
        }
    }
    
    func setTextField3() {
        textField3.snp.makeConstraints { make in
            make.leadingMargin.equalTo(20)
            make.trailingMargin.equalTo(-20)
            make.top.equalTo(textField2.snp.bottom).offset(20)
            make.bottom.equalTo(view.safeAreaLayoutGuide)
        }
    }
        
    
    
    

    
    

}
