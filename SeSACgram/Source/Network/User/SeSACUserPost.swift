//
//  SeSACMember.swift
//  SeSACgram
//
//  Created by hoon on 11/15/23.
//

import Foundation
import Moya

enum SeSACUserAPI {
    case signUP(data: SignUp)
    case logIn(email: String, pw: String)
    case checkEmail(email: Email)
    case tokenRefresh
    case withdraw
    
    func addHeaders() -> [String: String] {
        let authToken = UserDefaultsHelper.shared.authenticationToken
        var headers: [String: String] = ["SesacKey": SeSAC_API.apiKey,
                                         "Authorization": authToken ]
        
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

extension SeSACUserAPI: TargetType {
    
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
        case .tokenRefresh:
            return "/refresh"
        case .withdraw:
            return "/withdraw"
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .signUP, .logIn, .checkEmail:
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
        case .logIn(let email, let pw):
            let data = LogIn(email: email, pw: pw)
            return .requestJSONEncodable(data)
        case .tokenRefresh, .withdraw:
            return .requestPlain
        }
    }
    
    var headers: [String : String]? {
        switch self {
        case .signUP, .logIn, .checkEmail:
            return ["Content-Type": "application/json",
                    "SesacKey": SeSAC_API.apiKey]
        case .tokenRefresh, .withdraw:
            return addHeaders()
        }
    }
    
}
