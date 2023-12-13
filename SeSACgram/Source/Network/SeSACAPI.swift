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
    case post(data: Post)
    case inquiryPost(next: String?, limit: String, productId: String)
    
    private func addHeaders() -> [String: String] {
        let authToken = UserDefaultsHelper.shared.accessToken
        var headers: [String: String] = ["SesacKey": SeSAC_API.apiKey,
                                         "Authorization": authToken! ]
        
        switch self {
        case .tokenRefresh:
            let refreshToken = UserDefaultsHelper.shared.refreshToken
                headers["Refresh"] = refreshToken
        case .post:
            headers["Content-Type"] = "multipart/form-data"
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
        case .post, .inquiryPost:
            return "post"
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .checkEmail, .logIn, .signUP, .post:
            return .post
        case .tokenRefresh, .withdraw, .inquiryPost:
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
        case .post(let data):
            return .uploadMultipart(convertData(data: data))
        case .inquiryPost(let next, let limit, let productId):
            var param = ["limit": limit, "product_id": productId]
            if let next {
                param["next"] = next
            }
            return .requestParameters(parameters: param, encoding: URLEncoding.queryString)
        }
    }
    
    var headers: [String : String]? {
        switch self {
        case .checkEmail, .logIn, .signUP:
            return ["Content-Type": "application/json",
                    "SesacKey": SeSAC_API.apiKey]
        case .tokenRefresh, .withdraw, .post, .inquiryPost:
            return addHeaders()
        }
    }
}

extension SeSACAPI {
    var validationType: ValidationType {
        return .successCodes
    }
    
    private func convertData(data: Post) -> [MultipartFormData] {
        var formData: [MultipartFormData] = []
        
        for (index, fileData) in data.files.enumerated() {
            let fileName = "image\(index + 1).jpg"
            let formDataItem = MultipartFormData(provider: .data(fileData), name: "file", fileName: fileName, mimeType: "image/jpeg")
            formData.append(formDataItem)
        }
        
        let titleFormData = MultipartFormData(provider: .data(data.title.data(using: .utf8)!), name: "title")
        let contentFormData = MultipartFormData(provider: .data(data.content.data(using: .utf8)!), name: "content")
        let productIdFormData = MultipartFormData(provider: .data(data.product_id.data(using: .utf8)!), name: "product_id")
        
        formData.append(contentsOf: [titleFormData, contentFormData, productIdFormData])
        
        return formData
    }
}
