//
//  BaseViewController.swift
//  Diary
//
//  Created by hoon on 2023/08/28.
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
        print("Base ConfigureView")
    }
    
    
    
    func setConstraints() {
        print("Base SetConstraints")
    }
    


}
