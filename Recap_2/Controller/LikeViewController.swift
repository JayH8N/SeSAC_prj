//
//  LikeViewController.swift
//  Recap_2
//
//  Created by hoon on 2023/09/07.
//

import UIKit


class LikeViewController: BaseViewController {
    
    
    
    
    convenience init(title: String) {
        self.init()
        self.title = title
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func setNavigationBar() {
        navigationController?.navigationBar.titleTextAttributes = [.foregroundColor: UIColor.white]
    }
    
    
    override func configureView() {
        
    }
    
    
    override func setConstraints() {
        
    }
}
