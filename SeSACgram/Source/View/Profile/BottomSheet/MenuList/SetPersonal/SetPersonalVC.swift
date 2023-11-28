//
//  SetPersonalVC.swift
//  SeSACgram
//
//  Created by hoon on 11/27/23.
//

import UIKit

final class SetPersonalVC: BaseVC {
    
    private let mainView = SetPersonalView()
    
    
    convenience init(title: String) {
        self.init()
        self.title = title
    }
    
    override func loadView() {
        self.view = mainView
    }
    
    
    
}
