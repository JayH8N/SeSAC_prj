//
//  ResponseAPI.swift
//  SeSACgram
//
//  Created by hoon on 11/15/23.
//

import Foundation


//MARK: - 회원인증
struct EmailResponse: Decodable {
    let message: String
}

//회원가입, 탈퇴
struct SignUPWithdrawResponse: Decodable {
    let id: String
    let email: String
    let nick: String
    
    enum CodingKeys: String, CodingKey {
        case id = "_id"
        case email
        case nick
    }
}


struct LoginResponse: Decodable {
    let token: String
    let refreshToken: String
}

//토큰 갱신
struct RefreshToken: Decodable {
    let token: String
}
