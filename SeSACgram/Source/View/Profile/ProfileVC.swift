//
//  ProfileVC.swift
//  SeSACgram
//
//  Created by hoon on 11/14/23.
//

import UIKit

final class ProfileVC: BaseVC {
    
    let mainView = ProfileView()
    
    override func loadView() {
        self.view = mainView
        
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    
    deinit {
        print("====\(Self.self)====Deinit")
    }
}
