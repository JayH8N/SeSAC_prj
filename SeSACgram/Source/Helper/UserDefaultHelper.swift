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
            // 값 조회
            UserDefaults.standard.object(forKey: key) as? T ?? defaultValue
        }
        set {
            // 값 저장
            UserDefaults.standard.setValue(newValue, forKey: key)
        }
    }
}

class UserDefaultsHelper {
    static let shared = UserDefaultsHelper()
    
    private init() { }

    enum Key: String {
        case accessToken
        case refreshToken
        case email
        case pw
        case nickname
        case phone
        case isLogIn
    }
    
    @HoonDefaults(key: Key.accessToken.rawValue, defaultValue: "NonToken")
    var accessToken: String

    @HoonDefaults(key: Key.refreshToken.rawValue, defaultValue: "NonToken")
    var refreshToken: String
    
    @HoonDefaults(key: Key.email.rawValue, defaultValue: "Email")
    var email: String
    
    @HoonDefaults(key: Key.pw.rawValue, defaultValue: "Password")
    var pw: String
    
    @HoonDefaults(key: Key.nickname.rawValue, defaultValue: "Nickname")
    var nickname: String
    
    @HoonDefaults(key: Key.phone.rawValue, defaultValue: nil)
    var phone: String?
    
    @HoonDefaults(key: Key.isLogIn.rawValue, defaultValue: false)
    var isLogIn: Bool
    
    func removeAccessToken() {
        accessToken = "NonToken"
    }
    func removeRefreshToken() {
        refreshToken = "NonToken"
    }
}

