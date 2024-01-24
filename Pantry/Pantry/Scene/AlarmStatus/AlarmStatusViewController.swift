//
//  AlarmStatusViewController.swift
//  Pantry
//
//  Created by hoon on 2023/10/27.
//

import UIKit

class AlarmStatusViewController: BaseVC {
    
    let mainView = AlarmStatusView()
    
    override func loadView() {
        view = mainView
    }
    
    convenience init(title: String) {
        self.init()
        self.title = title
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func configureView() {
        
    }
    
}
