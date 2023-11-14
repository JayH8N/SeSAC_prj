//
//  ProfileVC.swift
//  SeSACgram
//
//  Created by hoon on 11/14/23.
//

import UIKit

class ProfileVC: UIViewController {
    
    let mainView = ProfileView()
    
    override func loadView() {
        self.view = mainView
        
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
}
