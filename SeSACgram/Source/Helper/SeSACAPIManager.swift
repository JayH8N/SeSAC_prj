//
//  SeSACAPIManager.swift
//  SeSACgram
//
//  Created by hoon on 11/15/23.
//

import Foundation
import Moya
import RxSwift
import RxCocoa


class SeSACAPIManager {
    static let shared = SeSACAPIManager()
    private let provider = MoyaProvider<SeSACUserPost>()

    private init() { }

    func signUp(signUpData: SignUp, completion: @escaping (Result<SignUpResponse, NetworkError>) -> Void) {
        let target = SeSACUserPost.signUP(data: signUpData)
        request(target, decodingType: SignUpResponse.self, completion: completion)
    }

    func logIn(email: String, password: String, completion: @escaping (Result<LoginResponse, NetworkError>) -> Void) {
        let target = SeSACUserPost.logIn(email: email, pw: password)
        request(target, decodingType: LoginResponse.self, completion: completion)
    }

    func checkEmail(email: Email, completion: @escaping (Result<EmailResponse, NetworkError>) -> Void) {
        let target = SeSACUserPost.checkEmail(email: email)
        request(target, decodingType: EmailResponse.self, completion: completion)
    }

    private func request<U: Decodable, T: TargetType>(_ target: T, decodingType: U.Type, completion: @escaping (Result<U, NetworkError>) -> Void) {
        provider.request(target as! SeSACUserPost) { result in
            switch result {
            case .success(let response):
                do {
                    let decodedData = try JSONDecoder().decode(U.self, from: response.data)
                    completion(.success(decodedData))
                } catch {
                    let networkError = NetworkError.mapError(error)
                    completion(.failure(networkError))
                }
            case .failure(let moyaError):
                let networkError = NetworkError.fromMoyaError(moyaError)
                completion(.failure(networkError))
            }
        }
    }
}



//SeSACAPIManager.shared.logIn(email: "example@example.com", password: "password") { result in
//    switch result {
//    case .success(let loginResponse):
//        // 성공적으로 디코딩된 데이터 처리
//    case .failure(let apiError):
//        switch apiError {
//        case .common(let commonError):
//            // CommonError에 대한 처리
//            print("Common Error: \(commonError)")
//        case .login(let loginError):
//            // LoginError에 대한 처리
//            print("Login Error: \(loginError)")
//        default:
//            // 다른 에러 케이스에 대한 처리
//            break
//        }
//    }
//}
