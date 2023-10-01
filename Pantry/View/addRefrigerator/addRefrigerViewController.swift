//
//  addRefrigerViewController.swift
//  Pantry
//
//  Created by hoon on 2023/09/28.
//

import Foundation

class addRefrigerViewController: BaseViewController {
    
    let mainView = addRefrigerView()
    
    override func loadView() {
        initNav()
        view = mainView
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    
}

extension addRefrigerViewController {
    private func initNav() {
        let addRefriger = NSLocalizedString("AddRefriger", comment: "")
        let cancel = NSLocalizedString("Cancel", comment: "")
        let add = NSLocalizedString("Add", comment: "")
        
        
        self.navigationItem.title = addRefriger
        self.navigationItem.rightBarButtonItem = .init(title: add, style: .done, target: self, action: #selector(addButtonTapped))
        self.navigationItem.leftBarButtonItem = .init(title: cancel, style: .done, target: self, action: #selector(cancelButtonTapped))
    }
}


extension addRefrigerViewController {
    
    @objc func addButtonTapped() {
        //냉장고 추가 작업 realm
    }
    
    @objc func cancelButtonTapped() {
        dismiss(animated: true)
    }
    
}
