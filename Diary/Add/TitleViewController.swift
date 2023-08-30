//
//  TitleViewController.swift
//  Diary
//
//  Created by hoon on 2023/08/29.
//

import UIKit


class TitleViewController: BaseViewController {
    
    let textField = {
       let view = UITextField()
        view.placeholder = "제목을 입력해주세요"
        return view
    }()
    
    //✅1.클로저 값전달
    var completionHandler: ((String) -> Void)?
    
    
    override func configureView() {
        super.configureView()
        
        view.addSubview(textField)
    }
    
    override func setConstraints() {
        textField.snp.makeConstraints { make in
            make.top.horizontalEdges.equalTo(view.safeAreaLayoutGuide).inset(10)
            make.height.equalTo(50)
        }
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        
        //✅2.클로저 값전달
        completionHandler?(textField.text!)
        
    }
}
