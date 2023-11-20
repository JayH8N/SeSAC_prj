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

struct SignUpResponse: Decodable {
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
