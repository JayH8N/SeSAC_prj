//
//  UserDefaultHelper.swift
//  SeSACgram
//
//  Created by hoon on 11/13/23.
//

import Foundation

@propertyWrapper
struct HoonDefaults<T> {
    let key: String
    let defaultValue: T
    
    var wrappedValue: T {
        get {
            //값 조회
            UserDefaults.standard.object(forKey: key) as? T ?? defaultValue
        }
        set {
            //값 저장
            UserDefaults.standard.setValue(newValue, forKey: key)
        }
    }
}


enum UseerDefaultsHelper {
    
    enum Key: String {
        case authenticationToken
    }
    
    @HoonDefaults(key: Key.authenticationToken.rawValue, defaultValue: "Token")
    static var authenticationToken
    
}
