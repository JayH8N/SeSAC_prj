//
//  BaseViewController.swift
//  Pantry
//
//  Created by hoon on 2023/09/25.
//

import UIKit

class BaseViewController: UIViewController {
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureView()
        setConstraints()
        setNavigationBar()
    }
    
    func setNavigationBar() { }
    
    func configureView() { }
    
    func setConstraints() { }
    
    
}
