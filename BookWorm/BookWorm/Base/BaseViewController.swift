//
//  BaseViewController.swift
//  BookWorm
//
//  Created by hoon on 2023/09/05.
//

import UIKit
import SnapKit

class BaseViewController: UIViewController {
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureView()
        setConstraints()
        
    }
    
    
    
    func configureView() {
        view.backgroundColor = .white
    }
    
    func setConstraints() {
        
    }
    
    
    
    
}
