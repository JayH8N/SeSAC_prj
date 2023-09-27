//
//  MainViewController.swift
//  Pantry
//
//  Created by hoon on 2023/09/25.
//

import UIKit


class MainViewController: BaseViewController {
    
    
    
    
    
    convenience init(title: String) {
        self.init()
        self.title = title
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func setNavigationBar() {
        self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.font: UIFont(name: "TiquiTaca-Regular", size: 30)!]
    }
}
