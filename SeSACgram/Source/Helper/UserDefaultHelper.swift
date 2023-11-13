//
//  UserDefaultHelper.swift
//  SeSACgram
//
//  Created by hoon on 11/13/23.
//

import Foundation

final class UseerDefaultsHelper {
    
    static let standard = UseerDefaultsHelper()
    
    private init() {}
    
    private let userDefaults = UserDefaults.standard
    
    enum ForKey: String {
        case authenticationToken
    }
    
    var authenticationToken: Bool {
        get {
            return userDefaults.bool(forKey: ForKey.authenticationToken.rawValue)
        }
        set {
            userDefaults.set(newValue, forKey: ForKey.authenticationToken.rawValue)
        }
    }
    
}
