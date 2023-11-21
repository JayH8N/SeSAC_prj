//
//  SeSACError.swift
//  SeSACgram
//
//  Created by hoon on 11/20/23.
//

import Foundation

enum NetworkError: Error {
    case common(CommonError)
    case signUp(SignUPError)
    case email(EmailError)
    case login(LoginError)
    case token(TokenError)
    case withdraw(WithdrawError)
}


enum CommonError: Int, Error {
    case missAPIKey = 420
    case overRequest = 429
    case invalidURL = 444
    case serverError = 500
}

enum SignUPError: Int, Error {
    case missingRequiredValue = 400
    case existingUser = 409
}

enum EmailError: Int, Error {
    case missingRequiredValue = 400
    case existingEmail = 409
}

enum LoginError: Int, Error {
    case missingRequiredValue = 400 //body에 필수값 누락
    case checkValue = 401 //미가입, 비밀번호 불일치
}

enum TokenError: Int, Error {
    case invalidToken = 401 //인증할 수 없는 액세스 토큰
    case forbidden = 403 //접근권한이 없는 경우
    case nonExpiring = 409 //액세스 토큰 만료되지 않음 -> 액세스 토큰 만료 후 재요청
    case expiredRefreshToken = 418 //⭐️ 로그인 화면으로 전환되어야 함
}

enum WithdrawError: Int, Error {
    case invalidToken = 401 //인증할 수 없는 액세스 토큰
    case forbidden = 403 //접근권한이 없는 경우
    case expiredExcessToken = 419 //⭐️ refresh라우터를 통한 토큰 갱신 필요
}

