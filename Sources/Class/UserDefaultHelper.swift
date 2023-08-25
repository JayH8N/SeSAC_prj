//
//  UserDefaultHelper.swift
//  Media
//
//  Created by hoon on 2023/08/25.
//

import Foundation

class UseerDefaultsHelper {
    
    static let standard = UseerDefaultsHelper()
    
    private init() {}
    
    let userDefaults = UserDefaults.standard
    
    enum ForKey: String {
        case isLaunched
    }
    
    var isLaunched: Bool {
        get {
            return userDefaults.bool(forKey: ForKey.isLaunched.rawValue)
        }
        set {
            userDefaults.set(newValue, forKey: ForKey.isLaunched.rawValue)
        }
    }
    
}
