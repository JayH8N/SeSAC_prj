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

    //이메일 중복확인
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
                    print("Error:\(commonError.errorDescription), statusCode:\(statusCode)")
                } else if let error = EmailCheckError(rawValue: statusCode) {
                    completion(.failure(error))
                    print("\(error.errorDescription)")
                }
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    //회원가입
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
                    print("Error:\(commonError.errorDescription), statusCode:\(statusCode)")
                } else if let error = SignUPError(rawValue: statusCode) {
                    completion(.failure(error))
                }
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    
    
    
    
}
