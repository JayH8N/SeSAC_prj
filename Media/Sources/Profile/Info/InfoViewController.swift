//
//  InfoViewController.swift
//  Media
//
//  Created by hoon on 2023/08/29.
//

import UIKit


class InfoViewController: BaseViewController {
    
    let mainView = InfoView()
    
    override func loadView() {
        self.view = mainView
    }
    
    var completionHandler: ((String) -> Void)?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.topItem?.title = ""
        title = "소개"
    }
    
    override func configureView() {
        super.configureView()
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "완료", style: .plain, target: self, action: #selector(doneButtonClicked))
        
    }
    
    @objc func doneButtonClicked() {
        
        completionHandler?(mainView.textView.text!)
        
        navigationController?.popViewController(animated: true)
    }
    
    
    
    override func setConstraints() {
        super.setConstraints()
    }
    
    
    
    
    
    
    
}
