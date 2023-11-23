//
//  SeSACAPIManager.swift
//  SeSACgram
//
//  Created by hoon on 11/15/23.
//

import Foundation
import Moya

//final class APIManager {
//    static let shared = APIManager()
//
//    private let userPostProvider = MoyaProvider<SeSACUserPost>()
//    private let userGetProvider = MoyaProvider<SeSACUserGet>()
//    
//    private init() { }
//    
//    //회원가입, 이메일중복확인, 로그인
//    func userPostReqeust<T: Encodable>(_ target: SeSACUserPost, completion: @escaping (Result<T, NetworkError>) -> Void) {
//        userPostProvider.request(target) { result in
//            switch result {
//            case .success(let data):
//                completion(.success(data as! T))
//            case .failure(let error):
//                let statusCode = error.response?.statusCode ?? 500
//                if let commonError = CommonError(rawValue: statusCode) {
//                    completion(.failure(NetworkError.commonError(commonError)))
//                } else {
//                    if case .signUP(_) = target {
//                        if let signUpError = SignUPError(rawValue: statusCode) {
//                            completion(.failure(NetworkError.signUPError(signUpError)))
//                            return
//                        }
//                    } else if case .checkEmail(_) = target {
//                        if let emailCheckError = EmailCheckError(rawValue: statusCode) {
//                            completion(.failure(NetworkError.emailCkeckError(emailCheckError)))
//                            return
//                        }
//                    } else if case .logIn(_, _) = target {
//                        if let logInError = LogInError(rawValue: statusCode) {
//                            completion(.failure(NetworkError.loginError(logInError)))
//                            return
//                        }
//                    }
//                }
//            }
//        }
//    }
//    
//    //토큰갱신, 회원탈퇴
//    func userGetRequest<T: Decodable>(_ target: SeSACUserGet, completion: @escaping (Result<T, NetworkError>) -> Void) {
//        userGetProvider.request(target) { result in
//            switch result {
//            case .success(let data):
//                completion(.success(data as! T))
//            case .failure(let error):
//                let statusCode = error.response?.statusCode ?? 500
//                if let commonError = CommonError(rawValue: statusCode) {
//                    completion(.failure(NetworkError.commonError(commonError)))
//                } else {
//                    if case .tokenRefresh = target {
//                        if let tokenError = TokenError(rawValue: statusCode) {
//                            completion(.failure(NetworkError.tokenError(tokenError)))
//                            return
//                        }
//                    } else if case .withdraw = target {
//                        if let withdrawError = WithdrawError(rawValue: statusCode) {
//                            completion(.failure(NetworkError.withdrawError(withdrawError)))
//                            return
//                        }
//                    }
//                }
//            }
//        }
//    }
//    
//    
//    //공통응답코드
//    func hnadleCommonError(_ statusCode: Int) throws {
//        
//    }
//    
//    
//}


class APIManager {
    static let shared = APIManager()

    private let provider = MoyaProvider<SeSACUserAPI>()

    // 회원가입
    func signUp(email: String, password: String, nick: String, tel: String?, birth: String?, completion: @escaping (Result<SignUPWithdrawResponse, NetworkError>) -> Void) {
        let signUpData = SignUp(email: email, password: password, nick: nick, tel: tel, birth: birth)
        request(target: .signUP(data: signUpData), completion: completion)
    }

    // 이메일 중복 체크
    func checkEmail(email: String, completion: @escaping (Result<EmailResponse, NetworkError>) -> Void) {
        let emailData = Email(email: email)
        request(target: .checkEmail(email: emailData), completion: completion)
    }

    // 로그인
    func logIn(email: String, password: String, completion: @escaping (Result<LoginResponse, NetworkError>) -> Void) {
        request(target: .logIn(email: email, pw: password), completion: completion)
    }

    // 토큰 갱신
    func refreshToken(completion: @escaping (Result<RefreshToken, NetworkError>) -> Void) {
        request(target: .tokenRefresh, completion: completion)
    }

    // 탈퇴
    func withdraw(completion: @escaping (Result<SignUPWithdrawResponse, NetworkError>) -> Void) {
        request(target: .withdraw, completion: completion)
    }

    // 공통으로 사용할 request 메서드
    private func request<T: Decodable>(target: SeSACUserAPI, completion: @escaping (Result<T, NetworkError>) -> Void) {
        provider.request(target) { result in
            switch result {
            case let .success(response):
                completion(.success(response as! T))
            case let .failure(moyaError):
                // Moya에서의 실패 상황을 NetworkError로 변환하여 실패 결과로 전달
                let networkError = NetworkError(moyaError: moyaError)
                completion(.failure(networkError))
            }
        }
    }

}

extension APIManager {
    private func handleError(_ error: NetworkError) {
            switch error {
            case .commonError(let commonError):
                handleCommonError(commonError)
            case .signUPError(let signUpError):
                handleSignUpError(signUpError)
            case .emailCkeckError(let emailCheckError):
                handleEmailCheckError(emailCheckError)
            case .loginError(let loginError):
                handleLoginError(loginError)
            case .tokenError(let tokenError):
                handleTokenError(tokenError)
            case .withdrawError(let withdrawError):
                handleWithdrawError(withdrawError)
            }
        }

        // 각 에러 별로 처리하는 함수 정의
        private func handleCommonError(_ commonError: CommonError) {
            // 공통 에러 처리 로직
        }

        private func handleSignUpError(_ signUpError: SignUPError) {
            // 회원가입 에러 처리 로직
        }

        private func handleEmailCheckError(_ emailCheckError: EmailCheckError) {
            // 이메일 중복 체크 에러 처리 로직
        }

        private func handleLoginError(_ loginError: LogInError) {
            // 로그인 에러 처리 로직
        }

        private func handleTokenError(_ tokenError: TokenError) {
            // 토큰 에러 처리 로직
        }

        private func handleWithdrawError(_ withdrawError: WithdrawError) {
            // 탈퇴 에러 처리 로직
        }
}
