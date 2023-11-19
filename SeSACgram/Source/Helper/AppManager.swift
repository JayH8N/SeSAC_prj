//
//  AppManager.swift
//  SeSACgram
//
//  Created by hoon on 11/19/23.
//

import UIKit
import Firebase
import IQKeyboardManagerSwift

class AppManager {
    static let shared = AppManager()
    
    private init() { }
    
    func configure() {
        sleep(2)
        FirebaseApp.configure()
        IQKeyboardManager.shared.enable = true
        IQKeyboardManager.shared.enableAutoToolbar = false
        UINavigationBar.appearance().tintColor = Constants.Color.DeepGreen
    }
    
}
