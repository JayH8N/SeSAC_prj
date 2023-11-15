//
//  SeSAC.swift
//  SeSACgram
//
//  Created by hoon on 11/15/23.
//

import Foundation
import Moya

enum SeSAC {
    case signUP(data: Join)
    case logIn(email: String, pw: String)
}

extension SeSAC: TargetType {
    
    var baseURL: URL {
        URL(string: SeSAC_API.baseURL)!
    }
    
    var path: String {
        switch self {
        case .signUP:
            return "join"
        case .logIn:
            return "login"
        }
    }
    
    var method: Moya.Method {
        return .post
    }
    
    var task: Moya.Task {
        switch self {
        case .signUP(let data):
            return .requestJSONEncodable(data)
        case .logIn(let email, let pw):
            let data = Login(email: email, pw: pw)
            return .requestJSONEncodable(data)
        }
    }
    
    var headers: [String : String]? {
        ["Content-Type": "application/json",
         "SesacKey": SeSAC_API.apiKey ]
    }
    
    
}
