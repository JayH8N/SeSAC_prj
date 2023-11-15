//
//  RequestAPI.swift
//  SeSACgram
//
//  Created by hoon on 11/15/23.
//

import Foundation

struct Join: Encodable {
    let email: String
    let password: String
    let nick: String
    let tel: String
    let birth: String
}

struct Login: Encodable {
    let email: String
    let pw: String
}
