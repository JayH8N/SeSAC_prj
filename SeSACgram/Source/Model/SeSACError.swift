//
//  SeSACError.swift
//  SeSACgram
//
//  Created by hoon on 11/20/23.
//
import Moya

//enum NetworkError: Error {
//    case commonError(CommonError)
//    case signUPError(SignUPError)
//    case emailCkeckError(EmailCheckError)
//    case loginError(LogInError)
//    case tokenError(TokenError)
//    case withdrawError(WithdrawError)
//    
//    init(statusCode: Int) {
//        switch statusCode {
//        case 420:
//            self = .commonError(.invalidAPIKey)
//        case 429:
//            self = .commonError(.serverOverCall)
//        case 444:
//            self = .commonError(.invalidURL)
//        case 500:
//            self = .commonError(.serverError)
//        default:
//            self = .commonError(.serverError)
//        }
//    }
//    
//    init(moyaError: MoyaError) {
//        if let statusCode = moyaError.response?.statusCode {
//            self.init(statusCode: statusCode)
//        } else {
//            self = .commonError(.serverError)
//        }
//    }
//    
//    
//}
//
enum CommonError: Int, Error {
    case invalidAPIKey = 420
    case serverOverCall = 429
    case invalidURL = 444
    case serverError = 500
}

enum SignUPError: Int, Error {
    case requiredValueMissing = 400//필수값 누락
    case existingUser = 409//이미가입한 유저일 경우 return
}

enum EmailCheckError: Int, Error {
    case invalidAPIKey = 420
    case serverOverCall = 429
    case invalidURL = 444
    case serverError = 500
    case requiredValueMissing = 400//필수값 누락
    case unableEmail = 409//사용불가능한 이메일
}


enum LogInError: Int, Error {
    case requiredValueMissing = 400//필수값 누락
    case unsubscribe = 401//계정확인(미가입 or 비밀번호 불일치)
}

enum TokenError: Int, Error {
    case UnauthenticatedToken = 401//인증할 수 없는 토큰
    case forbidden = 403//Forbidden
    case validToken = 409//토큰 만료되지 않음 -> 계속 사용
    case expiredRefreshToken = 418//리프레시 토큰 만료 -> 로그인 화면으로
}

enum WithdrawError: Int, Error {
    case unauthenticatedToken = 401//인증할 수 없는 토큰
    case forbidden = 403//Forbidden
    case expiredToken = 419//토믄만료 -> 토큰 갱신필요
}

//
//struct CommonError: Decodable {
//    let message: String?
//}
