//
//  BaseViewController.swift
//  Recap_2
//
//  Created by hoon on 2023/09/07.
//

import UIKit
import SnapKit

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
