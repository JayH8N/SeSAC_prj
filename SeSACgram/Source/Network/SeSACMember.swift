//
//  SeSACMember.swift
//  SeSACgram
//
//  Created by hoon on 11/15/23.
//

import Foundation
import Moya

enum SeSACMember {
    case signUP(data: SignUp)
    case logIn(email: String, pw: String)
    case checkEmail(email: Email)
}

extension SeSACMember: TargetType {
    
    var baseURL: URL {
        URL(string: SeSAC_API.baseURL)!
    }
    
    var path: String {
        switch self {
        case .signUP:
            return "join"
        case .logIn:
            return "login"
        case .checkEmail:
            return "/validation/email"
        }
    }
    
    var method: Moya.Method {
        return .post
    }
    
    var task: Moya.Task {
        switch self {
        case .checkEmail(let email):
            return .requestJSONEncodable(email)
        case .signUP(let data):
            return .requestJSONEncodable(data)
        case .logIn(let email, let pw):
            let data = LogIn(email: email, pw: pw)
            return .requestJSONEncodable(data)
        }
    }
    
    var headers: [String : String]? {
        ["Content-Type": "application/json",
         "SesacKey": SeSAC_API.apiKey ]
    }
    
}
