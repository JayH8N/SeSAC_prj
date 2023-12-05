//
//  AuthInterceptor.swift
//  SeSACgram
//
//  Created by hoon on 11/29/23.
//

import UIKit
import Moya
import Alamofire

class AuthInterceptor: RequestInterceptor {
    
    static let shared = AuthInterceptor()
    
    private init() { }
    
    func adapt(_ urlRequest: URLRequest, for session: Session, completion: @escaping (Result<URLRequest, Error>) -> Void) {
        guard urlRequest.url?.absoluteString.hasPrefix(SeSAC_API.baseURL) == true,
              let accessToken = UserDefaultsHelper.shared.accessToken,
              let refreshToken = UserDefaultsHelper.shared.refreshToken
        else {
            completion(.success(urlRequest))
            return
        }
        
        var urlRequest = urlRequest
        urlRequest.setValue(accessToken, forHTTPHeaderField: "Authorization")
        urlRequest.setValue(refreshToken, forHTTPHeaderField: "Refresh")
        completion(.success(urlRequest))
    }
    
    //Access토큰 만료시(토큰 갱신하기 위해 실행됨)
    func retry(_ request: Request, for session: Session, dueTo error: Error, completion: @escaping (RetryResult) -> Void) {
        guard let response = request.task?.response as? HTTPURLResponse, response.statusCode == 419
        else {
            completion(.doNotRetryWithError(error)) //419가 아닌경우엔 retry하지 않도록
            return
        }
        
        
        DispatchQueue.global().async {
            APIManager.shared.updateToken { result in
                switch result {
                case .success( _):
                    //토큰 재발급 성공
                    completion(.retry)
                case .failure(let error):
                    if let error = error as? TokenError {
                        switch error {
                        case .expiredRefreshToken:
                            //리프레시토큰 만료 -> 얼럿 띄운후, 로그인 화면으로 전환
                            UserDefaultsHelper.shared.isLogIn = false
                            NotificationCenter.default.post(name: Notification.Name.backToLogIn, object: nil)
                        default:
                            print("\(error.errorDescription)")
                        }
                    }
                }
            }
        }
    }
}
