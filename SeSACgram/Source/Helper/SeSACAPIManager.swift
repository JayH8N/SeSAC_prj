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


//class APIManager {
//    static let shared = APIManager()
//
//    private let usderPostProvider = MoyaProvider<SeSACUserPost>()
//    private let userGetProvider = MoyaProvider<SeSACUserGet>()
//
//    // 회원가입
//    func signUp(email: String, password: String, nick: String, tel: String?, birth: String?, completion: @escaping (Result<SignUPWithdrawResponse, NetworkError>) -> Void) {
//        let signUpData = SignUp(email: email, password: password, nick: nick, tel: tel, birth: birth)
//        usderPostProvider.request(.signUP(data: signUpData)) { result in
//            switch result {
//            case .success(let data):
//                if (200..<300).contains(data.statusCode) {
//                    if let decodedData = try? JSONDecoder().decode(, from: data.data) {
//                        completion(.success(decodedData))
//                    } //공통코드에 돌려넣기
//                }
//            case .failure(let error)
//                //아니면 직접 에러 핸들링 함수에 넣기
//            }
//        }
//    }
//
//
//    // 이메일 중복 체크
//    func checkEmail(email: String, completion: @escaping (Result<EmailResponse, NetworkError>) -> Void) {
//        let emailData = Email(email: email)
//        request(target: .checkEmail(email: emailData), completion: completion)
//    }
//
//    // 로그인
//    func logIn(email: String, password: String, completion: @escaping (Result<LoginResponse, NetworkError>) -> Void) {
//        request(target: .logIn(email: email, pw: password), completion: completion)
//    }
//
//    // 토큰 갱신
//    func refreshToken(completion: @escaping (Result<RefreshToken, NetworkError>) -> Void) {
//        request(target: .tokenRefresh, completion: completion)
//    }
//
//    // 탈퇴
//    func withdraw(completion: @escaping (Result<SignUPWithdrawResponse, NetworkError>) -> Void) {
//        request(target: .withdraw, completion: completion)
//    }
//
//    // 공통으로 사용할 request 메서드
//    private func request<T: Decodable>(target: SeSACUserAPI, completion: @escaping (Result<T, NetworkError>) -> Void) {
//        provider.request(target) { result in
//            switch result {
//            case let .success(response):
//                completion(.success(response as! T))
//            case let .failure(moyaError):
//                // Moya에서의 실패 상황을 NetworkError로 변환하여 실패 결과로 전달
//                let networkError = NetworkError(moyaError: moyaError)
//                completion(.failure(networkError))
//            }
//        }
//    }
//
//}
//    
//
//extension APIManager {
//    
//    private func commonHandleError(_ error: NetworkError) {
//        switch error {
//        case .commonError(let commonError):
//            
//        }
//    }
//    
//    private func handleError(_ error: NetworkError) {
//            switch error {
//            case .commonError(let commonError):
//                handleCommonError(commonError)
//            case .signUPError(let signUpError):
//                handleSignUpError(signUpError)
//            case .emailCkeckError(let emailCheckError):
//                handleEmailCheckError(emailCheckError)
//            case .loginError(let loginError):
//                handleLoginError(loginError)
//            case .tokenError(let tokenError):
//                handleTokenError(tokenError)
//            case .withdrawError(let withdrawError):
//                handleWithdrawError(withdrawError)
//            }
//        }
//
//        // 각 에러 별로 처리하는 함수 정의
//        private func handleCommonError(_ commonError: CommonError) {
//            // 공통 에러 처리 로직
//        }
//
//        private func handleSignUpError(_ signUpError: SignUPError) {
//            // 회원가입 에러 처리 로직
//        }
//
//        private func handleEmailCheckError(_ emailCheckError: EmailCheckError) {
//            // 이메일 중복 체크 에러 처리 로직
//        }
//
//        private func handleLoginError(_ loginError: LogInError) {
//            // 로그인 에러 처리 로직
//        }
//
//        private func handleTokenError(_ tokenError: TokenError) {
//            // 토큰 에러 처리 로직
//        }
//
//        private func handleWithdrawError(_ withdrawError: WithdrawError) {
//            // 탈퇴 에러 처리 로직
//        }
//}

//class APIManager {
    
//    static let shared = APIManager()
//    private init() { }
    
//    private let userPostProvider = MoyaProvider<SeSACUserPost>()
//    private let userGetProvider = MoyaProvider<SeSACUserGet>()
 //   private let provider = MoyaProvider<SeSACAPI>()
    
    
    //로그인
//    func LogIn<T: Decodable>(model: T.Type, email: String, password: String, completion: @escaping (Result<T, Error>) -> Void) {
//        provider.request(.logIn(email: email, pw: password)) { result in
//            switch result {
//            case .success(let data):
//                let statusCode = data.statusCode
//                if statusCode == 200 {
//                    let result = try! JSONDecoder().decode(model, from: data.data)
//                    completion(.success(result))
//                    UserDefaultsHelper.shared.authenticationToken
//                } else {
//                    let result = try! JSONDecoder().decode(CommonError.self, from: data.data)
//                    let error = NSError(domain: result.message ?? "Error" , code: statusCode)
//                    completion(.failure(error))
//                }
//            case .failure(let error):
//                completion(.failure(error))
//            }
//        }
//    }
    
//    func LogIn(id: String, pw: String) {
//        provider.request(.logIn(email: id, pw: pw)) { result in
//            switch result {
//            case .success(let data):
//                let statusCode = data.statusCode
//                if statusCode == 200 {
//                    let result = try! JSONDecoder().decode(LoginResponse.self, from: data.data)
//                    UserDefaultsHelper.shared.authenticationToken = result.token
//                    UserDefaultsHelper.shared.refreshToken = result.refreshToken
//                } else {
//                    let result = try! JSONDecoder().decode(CommonError.self, from: data.data)
//                    let error = NSError(domain: result.message ?? "Error", code: statusCode)
//                    print(error)
//                }
//            case .failure(let error):
//                print("\(error)")
//            }
//        }
//    }
//    
//    
//   
//    //회원가입 --> completion필요없음
//    func SignUP<T: Decodable>(model: T.Type, email: String, password: String, nick: String, tel: String?, birth: String?, completion: @escaping (Result<T, Error>) -> Void) {
//        let data = SignUp(email: email, password: password, nick: nick, tel: tel, birth: birth)
//        provider.request(.signUP(data: data)) { result in
//            switch result {
//            case .success(let data):
//                let statusCode = data.statusCode
//                if statusCode == 200 {
//                    let result = try! JSONDecoder().decode(model, from: data.data)
//                    completion(.success(result))
//                } else {
//                    let result = try! JSONDecoder().decode(CommonError.self, from: data.data)
//                    let error = NSError(domain: result.message ?? "Error" , code: statusCode)
//                    completion(.failure(error))
//                }
//            case .failure(let error):
//                completion(.failure(error))
//            }
//        }
//    }
//    
//    //이메일 중복확인
//    func emailCheck<T: Decodable>(model: T.Type, email: String, completion: @escaping (Result<T, Error>) -> Void) {
//        let data = Email(email: email)
//        provider.request(.checkEmail(email: data)) { result in
//            switch result {
//            case .success(let data):
//                let statusCode = data.statusCode
//                if statusCode == 200 {
//                    let result = try! JSONDecoder().decode(model, from: data.data)
//                    completion(.success(result))
//                } else {
//                    let result = try! JSONDecoder().decode(CommonError.self, from: data.data)
//                    let error = NSError(domain: result.message ?? "Error" , code: statusCode)
//                    completion(.failure(error))
//                }
//            case .failure(let error):
//                completion(.failure(error))
//            }
//        }
//    }
//    
//    //토큰 갱신
//    func tokenCheck(completion: @escaping (Result<RefreshToken, Error>) -> Void) {
//        provider.request(.tokenRefresh) { result in
//            switch result {
//            case .success(let data):
//                let statusCode = data.statusCode
//                if statusCode == 200 {
//                    let result = try! JSONDecoder().decode(RefreshToken.self, from: data.data)
//                    //유저디폴트로 새토큰 저장
//                } else {
//                    let result = try! JSONDecoder().decode(CommonError.self, from: data.data)
//                    let error = NSError(domain: result.message ?? "Error" , code: statusCode)
//                    completion(.failure(error)) //컴플리션 말고 공통에러 코드 핸들링메서드 넣어버리기 handlingCommonError(error: statusCode)
//                }
//            case .failure(let error):
//                completion(.failure(error)) //토큰 에러 핸들링 메서드 넣어버리기
//            }
//        }
//    }
//    
//    //탈퇴
//    func withdraw<T: Decodable>(model: T.Type, completion: @escaping (Result<T, Error>) -> Void) {
//        provider.request(.withdraw) { result in
//            switch result {
//            case .success(let data):
//                let statusCode = data.statusCode
//                if statusCode == 200 {
//                    let result = try! JSONDecoder().decode(model, from: data.data)
//                    completion(.success(result))
//                } else {
//                    let result = try! JSONDecoder().decode(CommonError.self, from: data.data)
//                    let error = NSError(domain: result.message ?? "Error" , code: statusCode)
//                    completion(.failure(error))
//                }
//            case .failure(let error):
//                //completion(.failure(error))
//                let statusCode = error.response?.statusCode
//                guard let error = WithdrawError(rawValue: statusCode ?? 500) else { return }
//               //self.handlingWithdrawError(error: error)
//            }
//        }
//    }
//}


//extension APIManager {
    
    
    
    
    //    //토큰갱신 에러핸들링
    //    private func handlingTokenCheckError(error: TokenError) {
    //        switch error {
    //        case .UnauthenticatedToken:
    //            print("인증할 수 없는 액세스 토큰입니다.")
    //        case .forbidden:
    //            print("Forbidden : 접근권한이 없습니다.")
    //        case .validToken:
    //            print("액세스 토큰 만료되지 않았습니다.")
    //        case .expiredRefreshToken:
    //            //리프레시 토큰 만료, 로그인 화면으로 전환
    //        }
    //    }
    //
    //    //탈퇴 에러핸들링
    //    private func handlingWithdrawError(error: WithdrawError) {
    //        switch error {
    //        case .unauthenticatedToken:
    //            print("인증할 수 없는 액세스 토큰입니다.")
    //        case .forbidden:
    //            print("Forbidden : 접근권한이 없습니다.")
    //        case .expiredToken:
    //            tokenCheck(model: RefreshToken.self) { <#Result<Decodable, Error>#> in
    //                <#code#>
    //            }
    //        }
    //    }
    //
    //}
    
    //1.NSError에 관해 물어보기
    //2.위 코드를 예시로 에러핸들링 해보기
    //3.가 타입별로 에러 핸들링 메서드 만들어서 처리해보기
    
    //iOS 전기수 토큰 관리 로직 보기
    //Rx최종적으로 연결하기
    //값전달해서 회원가입시 써먹기
    
    
    //어쩌면 컴프리션 핸들러자체가 필용없어보임 ?
//}


import Moya

final class APIManager {
    static let shared = APIManager()
    private let provider = MoyaProvider<SeSACAPI>()

    private init() {}

    func checkEmail(email: String, completion: @escaping (Result<EmailResponse, Error>) -> Void) {
        let emailModel = Email(email: email)

        provider.request(.checkEmail(email: emailModel)) { result in
            switch result {
            case .success(let value):
                let statusCode = value.statusCode
                
                if statusCode == 200 {
                    let result = try! JSONDecoder().decode(EmailResponse.self, from: value.data)
                    completion(.success(result))
                    print("======성공")
                } else {
                    completion(.failure(EmailCheckError(rawValue: statusCode)!))
                }
            case .failure(let error):
                completion(.failure(error))
                print("======실패")
            }
        }
    }
}



// 200번대가 아닌 경우 CommonError 처리
//                        let commonError = try response.map(CommonError.self)
//                        if let commonMessage = commonError.message {
//                            print("Common Error Message: \(commonMessage)")
//                        }
