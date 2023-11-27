//
//  SeSACAPIManager.swift
//  SeSACgram
//
//  Created by hoon on 11/15/23.
//

import Foundation
import Moya

final class APIManager {
    static let shared = APIManager()
    private let provider = MoyaProvider<SeSACAPI>()

    private init() {}

    //MARK: - 이메일 중복확인
    func checkEmail(email: String, completion: @escaping (Result<EmailResponse, Error>) -> Void) {
        let emailModel = Email(email: email)

        provider.request(.checkEmail(email: emailModel)) { result in
            switch result {
            case .success(let value):
                let statusCode = value.statusCode
                if statusCode == 200 {
                    print("==사용가능한 이메일==")
                    let result = try! JSONDecoder().decode(EmailResponse.self, from: value.data)
                    completion(.success(result))
                } 
                if let commonError = CommonError(rawValue: statusCode) {
                    print("Error:\(commonError.errorDescription)")
                } else if let error = EmailCheckError(rawValue: statusCode) {
                    completion(.failure(error))
                    print("\(error.errorDescription)")
                }
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    //MARK: - 회원가입
    func signUp(data: SignUp, completion: @escaping (Result<SignUPWithdrawResponse, Error>) -> Void) {
        provider.request(.signUP(data: data)) { result in
            switch result {
            case .success(let value):
                let statusCode = value.statusCode
                if statusCode == 200 {
                    print("==회원가입 성공==")
                    let result = try! JSONDecoder().decode(SignUPWithdrawResponse.self, from: value.data)
                    completion(.success(result))
                }
                if let commonError = CommonError(rawValue: statusCode) {
                    print("Error:\(commonError.errorDescription)")
                } else if let error = SignUPError(rawValue: statusCode) {
                    completion(.failure(error))
                }
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    //MARK: - 로그인
    func login(data: LogIn, completion: @escaping (Result<LoginResponse,Error>) -> Void) {
        provider.request(.logIn(data: data)) { result in
            switch result {
            case .success(let value):
                let statusCode = value.statusCode
                if statusCode == 200 {
                    print("==로그인 성공==")
                    let result = try! JSONDecoder().decode(LoginResponse.self, from: value.data)
                    UserDefaultsHelper.shared.authenticationToken = result.token
                    UserDefaultsHelper.shared.refreshToken = result.refreshToken
                    completion(.success(result))
                }
                if let commonError = CommonError(rawValue: statusCode) {
                    print("Error:\(commonError.errorDescription)")
                } else if let error = LogInError(rawValue: statusCode) {
                    completion(.failure(error))
                    //print("\(error.errorDescription)")
                }
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    //MARK: - 토큰갱신
    func updateToken(completion: @escaping (Result<RefreshToken,Error>) -> Void) {
        provider.request(.tokenRefresh) { result in
            switch result {
            case.success(let value):
                let statusCode = value.statusCode
                if statusCode == 200 {
                    let result = try! JSONDecoder().decode(RefreshToken.self, from: value.data)
                    print("==토큰 갱신완료==")
                    completion(.success(result))
                }
                if let commonError = CommonError(rawValue: statusCode) {
                    print("Error:\(commonError.errorDescription)")
                } else if let error = TokenError(rawValue: statusCode) {
                    completion(.failure(error))
                    print("\(error.errorDescription)")
                }
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    //MARK: - 탈퇴
    func withdraw(completion: @escaping (Result<SignUPWithdrawResponse,Error>) -> Void) {
        provider.request(.withdraw) { result in
            switch result {
            case .success(let value):
                let statusCode = value.statusCode
                if statusCode == 200 {
                    print("==탈퇴 성공==")
                    let result = try! JSONDecoder().decode(SignUPWithdrawResponse.self, from: value.data)
                    completion(.success(result))
                }
                if let commonError = CommonError(rawValue: statusCode) {
                    print("Error:\(commonError.errorDescription)")
                } else if let error = WithdrawError(rawValue: statusCode) {
                    completion(.failure(error))
                }
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}
