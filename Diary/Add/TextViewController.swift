//
//  TextViewController.swift
//  Diary
//
//  Created by hoon on 2023/08/29.
//

import UIKit


class TextViewController: BaseViewController {
    
    let textview = {
        let view = UITextView()
        view.backgroundColor = .lightGray
        return view
    }()
//
//    let storeButton = {
//        let view = UIButton()
//        view.setTitle("저장", for: .normal)
//        view.tintColor = .black
//        return view
//    }()
    
    
    var completionHandler: ((String, Int, Bool) -> Void)?
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //storeButton.addTarget(self, action: #selector(storeButtonClicked), for: .touchUpInside)
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        
        completionHandler?(textview.text!, 0, true)
    }
    
    @objc func storeButtonClicked() {
            navigationController?.popViewController(animated: true)
    }
    
    
    override func configureView() {
        super.configureView()
        
        view.addSubview(textview)
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "완료", style: .plain, target: self, action: #selector(doneButtonClicked))
    }
    
    
    @objc func doneButtonClicked() {
        completionHandler?(textview.text!, 1, false)
        
        navigationController?.popViewController(animated: true)
    }
    
    
    override func setConstraints() {
        textview.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide)
            make.leading.trailing.equalToSuperview().inset(10)
            make.height.equalTo(100)
        }
    }
    
    
    
    
    
}
