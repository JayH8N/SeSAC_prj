//
//  UserDefaultHelper.swift
//  SeSAC3Week4
//
//  Created by hoon on 2023/08/11.
//

import Foundation

class UserDefaultsHelper {  //PropertyWrapper??
    
    static let standard = UserDefaultsHelper() //각 뷰컨들에 인스턴스 생성할 필요가 없어진다.
    //싱글톤패턴
    
    private init() { } //접근 제어자(다음주) --> 다른 뷰컨에서 이 클래스를 초기화 하려고 한다면 오류가 나게 된다. 생성자에 잠금장치를 걸어버리는 것
    
    
    let userDefaults = UserDefaults.standard

    enum Key: String { //컴파일 최적화
        case nickname, age
    }
    
    var nickname: String {
        get {
            return userDefaults.string(forKey: Key.nickname.rawValue) ?? "대장"
        }
        set {
            userDefaults.set(newValue, forKey: Key.nickname.rawValue)
        }
    }
    
    
    var age: Int {
        get {
            return userDefaults.integer(forKey: Key.age.rawValue)
        }
        set {
            userDefaults.set(newValue, forKey: Key.age.rawValue)
        }
    }
    
    
}
