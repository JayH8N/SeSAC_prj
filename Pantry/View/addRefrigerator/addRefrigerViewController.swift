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
        //view.backgroundColor = .black
        
    }
    
    
    override func setNavigationBar() {
        
    }
    
}

extension addRefrigerViewController {
    private func initNav() {
        self.navigationItem.title = "냉장고 추가"
    }
}
