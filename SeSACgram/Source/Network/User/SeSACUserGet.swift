//
//  SeSACUserGet.swift
//  SeSACgram
//
//  Created by hoon on 11/21/23.
//

import Foundation
import Moya

enum SeSACUserGet {
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

extension SeSACUserGet: TargetType {
    
    var baseURL: URL {
        URL(string: SeSAC_API.baseURL)!
    }
    
    var path: String {
        switch self {
        case .tokenRefresh:
            return "/refresh"
        case .withdraw:
            return "/withdraw"
        }
    }
    
    var method: Moya.Method {
        return .get
    }
    
    var task: Moya.Task {
        .requestPlain
    }
    
    var headers: [String : String]? {
        return addHeaders()
    }
}
