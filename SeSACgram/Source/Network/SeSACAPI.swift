//
//  SeSACAPI.swift
//  SeSACgram
//
//  Created by hoon on 11/15/23.
//

import Foundation
import Moya

enum SeSACAPI {
    case signUP(data: SignUp)
    case logIn(data: LogIn)
    case checkEmail(email: Email)
    case tokenRefresh
    case withdraw
    
    func addHeaders() -> [String: String] {
        let authToken = UserDefaultsHelper.shared.accessToken
        var headers: [String: String] = ["SesacKey": SeSAC_API.apiKey,
                                         "Authorization": authToken! ]
        
        switch self {
        case .tokenRefresh:
            let refreshToken = UserDefaultsHelper.shared.refreshToken
                headers["Refresh"] = refreshToken
        default:
            break
        }
        return headers
    }
}

extension SeSACAPI: TargetType {
    
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
            return "validation/email"
        case .tokenRefresh:
            return "refresh"
        case .withdraw:
            return "withdraw"
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .checkEmail, .logIn, .signUP:
            return .post
        case .tokenRefresh, .withdraw:
            return .get
        }
    }
    
    var task: Moya.Task {
        switch self {
        case .checkEmail(let email):
            return .requestJSONEncodable(email)
        case .signUP(let data):
            return .requestJSONEncodable(data)
        case .logIn(let data):
            return .requestJSONEncodable(data)
        case .tokenRefresh, .withdraw:
            return .requestPlain
        }
    }
    
    var headers: [String : String]? {
        switch self {
        case .checkEmail, .logIn, .signUP:
            return ["Content-Type": "application/json",
                    "SesacKey": SeSAC_API.apiKey]
        case .tokenRefresh, .withdraw:
            return addHeaders()
        }
    }
}

extension SeSACAPI {
    var validationType: ValidationType {
        return .successCodes
    }
}
