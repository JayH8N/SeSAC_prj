//
//  RequestAPI.swift
//  SeSACgram
//
//  Created by hoon on 11/15/23.
//

import Foundation


//MARK: - 회원인증
struct Email: Encodable {
    let email: String
}

struct SignUp: Encodable {
    let email: String
    let password: String
    let nick: String
    let phoneNum: String?
    let birthDay: String?
}

struct LogIn: Encodable {
    let email: String
    let password: String
}

