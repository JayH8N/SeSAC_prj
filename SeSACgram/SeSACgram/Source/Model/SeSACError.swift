//
//  SeSACError.swift
//  SeSACgram
//
//  Created by hoon on 11/20/23.
//
import Foundation
import Moya

//MARK: - 공통응답 코드
enum CommonError: Int, Error, LocalizedError {
    case invalidAPIKey = 420
    case serverOverCall = 429
    case invalidURL = 444
    case serverError = 500
    
    var errorDescription: String {
        switch self {
        case .invalidAPIKey:
            return "===유효하지 않은 인증키 : \(self.rawValue)==="
        case .serverOverCall:
            return "===서버 과호출 : \(self.rawValue)==="
        case .invalidURL:
            return "===유효하지 않은 URL : \(self.rawValue)==="
        case .serverError:
            return "===Server Error : \(self.rawValue)==="
        }
    }
}
//MARK: - 회원가입 응답코드
enum SignUPError: Int, Error, LocalizedError {
    case requiredValueMissing = 400
    case existingUser = 409
    
    var errorDescription: String {
        switch self {
        case .requiredValueMissing:
            return "===필수값을 채워주세요 : \(self.rawValue)==="
        case .existingUser:
            return "===이미 가입한 유저입니다 : \(self.rawValue)==="
        }
    }
}
//MARK: - 이메일중복확인 응답코드
enum EmailCheckError: Int, Error, LocalizedError {
    case requiredValueMissing = 400
    case unableEmail = 409
    
    var errorDescription: String {
        switch self {
        case .requiredValueMissing:
            return "===필수값을 채워주세요 : \(self.rawValue)==="
        case .unableEmail:
            return "===사용이 불가한 이메일입니다. : \(self.rawValue)==="
        }
    }
}

//MARK: - 로그인 응답코드
enum LogInError: Int, Error, LocalizedError {
    case requiredValueMissing = 400//필수값 누락
    case unsubscribe = 401//계정확인(미가입 or 비밀번호 불일치)
    
    var errorDescription: String {
        switch self {
        case .requiredValueMissing:
            return "===필수값을 채워주세요 : \(self.rawValue)==="
        case .unsubscribe:
            return "===계정을 확인해주세요 : \(self.rawValue)==="
        }
    }
}
//MARK: - 토큰갱신 응답코드
enum TokenError: Int, Error, LocalizedError {
    case UnauthenticatedToken = 401//인증할 수 없는 토큰
    case forbidden = 403//Forbidden
    case validToken = 409//토큰 만료되지 않음 -> 계속 사용
    case expiredRefreshToken = 418//리프레시 토큰 만료 -> 로그인 화면으로
    
    var errorDescription: String {
        switch self {
        case .UnauthenticatedToken:
            return "===인증할 수 없는 토큰입니다. : \(self.rawValue)==="
        case .forbidden:
            return "===접근권한이 없습니다. : \(self.rawValue)==="
        case .validToken:
            return "===액세스토큰이 만료되지 않았습니다. : \(self.rawValue)==="
        case .expiredRefreshToken:
            return "===리프레시 토큰이 만료되었습니다. : \(self.rawValue)==="
        }
    }
}
//MARK: - 탈퇴 응답코드
enum WithdrawError: Int, Error, LocalizedError {
    case unauthenticatedToken = 401//인증할 수 없는 토큰
    case forbidden = 403//Forbidden
    case expiredToken = 419//토큰만료 -> 토큰 갱신필요
    
    var errorDescription: String {
        switch self {
        case .unauthenticatedToken:
            return "===인증할 수 없는 토큰입니다. : \(self.rawValue)==="
        case .forbidden:
            return "===접근권한이 없습니다. : \(self.rawValue)==="
        case .expiredToken:
            return "===액세스 토큰이 만료되었습니다. 토큰을 재발급해주세요 : \(self.rawValue)==="
        }
    }
}
//MARK: - Post응답코드
enum PostError: Int, Error, LocalizedError {
    case invalidRequest = 400 //잘못된 요청
    case unauthenticatedToken = 401 //인증할 수 없는 토큰
    case forbidden = 403
    case emptyDB = 410 //DB서버 장애로 게시글이 저장되지 않았을때
    case expiredToken = 419//토큰만료 -> 토큰 갱신필요
    
    var errorDescription: String {
        switch self {
        case .invalidRequest:
            return "===잘못된 요청입니다. : \(self.rawValue)==="
        case .unauthenticatedToken:
            return "===인증할 수 없는 액세스 토큰입니다. : \(self.rawValue)==="
        case .forbidden:
            return "===접근권한이 없습니다. : \(self.rawValue)==="
        case .emptyDB:
            return "===생성된 게시글이 없습니다. : \(self.rawValue)==="
        case .expiredToken:
            return "===액세스 토큰이 만료되었습니다. 토큰을 재발급해주세요 : \(self.rawValue)==="
        }
    }
}
//MARK: - Profile응답코드
enum ProfileError: Int, Error, LocalizedError {
    case unauthenticatedToken = 401 //인증할 수 없는 토큰
    case forbidden = 403
    case expiredToken = 419
    
    var errorDescription: String {
        switch self {
        case .unauthenticatedToken:
            return "===인증할 수 없는 액세스 토큰입니다. : \(self.rawValue)==="
        case .forbidden:
            return "===접근권한이 없습니다. : \(self.rawValue)==="
        case .expiredToken:
            return "===액세스 토큰이 만료되었습니다. 토큰을 재발급해주세요 : \(self.rawValue)==="
        }
    }
}
