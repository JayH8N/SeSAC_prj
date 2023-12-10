//
//  SeSACAPIManager.swift
//  SeSACgram
//
//  Created by hoon on 11/15/23.
//

import Foundation
import Moya
import Alamofire

final class APIManager {
    static let shared = APIManager()
    private let provider = MoyaProvider<SeSACAPI>(session: Session(interceptor: AuthInterceptor.shared))
    //private let provider = MoyaProvider<SeSACAPI>()
    

    private init() {}
    
//    private func performRequest<T: Decodable>(_ target: SeSACAPI, completion: @escaping (Result<T, Error>) -> Void) {
//        provider.request(target) { result in
//            switch result {
//            case .success(let value):
//                let statusCode = value.statusCode
//                if statusCode == 200 {
//                    let result = try! JSONDecoder().decode(T.self, from: value.data)
//                    completion(.success(result))
//                }
//                if let commonError = CommonError(rawValue: statusCode) {
//                    print("Error:\(commonError.errorDescription)")
//                    completion(.failure(commonError))
//                } else {
//                    completion(.failure(error))
//                }
//            case .failure(let error):
//                completion(.failure(error))
//            }
//        }
//    }

    //MARK: - 이메일 중복확인
    func checkEmail(email: String, completion: @escaping (Result<EmailResponse, Error>) -> Void) {
        let emailModel = Email(email: email)
        provider.request(.checkEmail(email: emailModel)) { result in
            switch result {
            case .success(let value):
                let result = try! JSONDecoder().decode(EmailResponse.self, from: value.data)
                completion(.success(result))
            case .failure(let error):
                let statusCode = error.response?.statusCode ?? 500
                if let commonError = CommonError(rawValue: statusCode) {
                    print("Error:\(commonError.errorDescription)")
                } else if let error = EmailCheckError(rawValue: statusCode) {
                    completion(.failure(error))
                }
            }
        }
    }
    
    //MARK: - 회원가입
    func signUp(data: SignUp, completion: @escaping (Result<SignUPWithdrawResponse, Error>) -> Void) {
        provider.request(.signUP(data: data)) { result in
            switch result {
            case .success(let value):
                let result = try! JSONDecoder().decode(SignUPWithdrawResponse.self, from: value.data)
                completion(.success(result))
            case .failure(let error):
                let statusCode = error.response?.statusCode ?? 500
                if let commonError = CommonError(rawValue: statusCode) {
                    print("Error:\(commonError.errorDescription)")
                } else if let error = SignUPError(rawValue: statusCode) {
                    completion(.failure(error))
                }
            }
        }
    }
    
    //MARK: - 로그인
    func login(data: LogIn, completion: @escaping (Result<LoginResponse,Error>) -> Void) {
        provider.request(.logIn(data: data)) { result in
            switch result {
            case .success(let value):
                let result = try! JSONDecoder().decode(LoginResponse.self, from: value.data)
                completion(.success(result))
            case .failure(let error):
                let statusCode = error.response?.statusCode ?? 500
                if let commonError = CommonError(rawValue: statusCode) {
                    print("Error:\(commonError.errorDescription)")
                } else if let error = LogInError(rawValue: statusCode) {
                    completion(.failure(error))
                }
            }
        }
    }
    
    //MARK: - 토큰갱신
    func updateToken(completion: @escaping (Result<RefreshToken,Error>) -> Void) {
        provider.request(.tokenRefresh) { result in
            switch result {
            case.success(let value):
                let result = try! JSONDecoder().decode(RefreshToken.self, from: value.data)
                print("==토큰 갱신완료==")
                UserDefaultsHelper.shared.accessToken = result.token
                completion(.success(result))
            case .failure(let error):
                let statusCode = error.response?.statusCode ?? 500
                if let commonError = CommonError(rawValue: statusCode) {
                    print("Error:\(commonError.errorDescription)")
                } else if let error = TokenError(rawValue: statusCode) {
                    completion(.failure(error))
                    print("\(error.errorDescription)")
                }
            }
        }
    }
    
    //MARK: - 탈퇴
    func withdraw(completion: @escaping (Result<SignUPWithdrawResponse,Error>) -> Void) {
        provider.request(.withdraw) { result in
            switch result {
            case .success(let value):
                let result = try! JSONDecoder().decode(SignUPWithdrawResponse.self, from: value.data)
                completion(.success(result))
            case .failure(let error):
                let statusCode = error.response?.statusCode ?? 500
                if let commonError = CommonError(rawValue: statusCode) {
                    print("Error:\(commonError.errorDescription)")
                } else if let error = WithdrawError(rawValue: statusCode) {
                    completion(.failure(error))
                }
            }
        }
    }

    //MARK: - Post
    func post(images: [Data], title: String, content: String, completion: @escaping (Result<PostResponse,Error>) -> Void) {
        let data = Post(title: title, content: content, files: images)
        provider.request(.post(data: data)) { result in
            switch result {
            case .success(let value):
                let result = try! JSONDecoder().decode(PostResponse.self, from: value.data)
                print("포스트 게시 완료")
                completion(.success(result))
            case .failure(let error):
                let statusCode = error.response?.statusCode ?? 500
                if let commonError = CommonError(rawValue: statusCode) {
                    print("Error:\(commonError.errorDescription)")
                } else if let error = PostError(rawValue: statusCode) {
                    completion(.failure(error))
                }
            }
        }
    }
    
}


