//
//  ResponseAPI.swift
//  SeSACgram
//
//  Created by hoon on 11/15/23.
//

import Foundation


//MARK: - 회원인증
struct EmailResponse: Decodable {
    let message: String
}

//회원가입, 탈퇴
struct SignUPWithdrawResponse: Decodable {
    let id: String
    let email: String
    let nick: String
    
    enum CodingKeys: String, CodingKey {
        case id = "_id"
        case email
        case nick
    }
}


struct LoginResponse: Decodable {
    let token: String
    let refreshToken: String
}

//토큰 갱신
struct RefreshToken: Decodable {
    let token: String
}

//MARK: - Post
struct PostResponse: Decodable {
    let likes, image, comments, hashTags: [String]
    let creator: Creator
    let time, title, content: String
}

struct Creator: Decodable {
    let nick: String
}
//MARK: - InquiryPost
struct InquiryPostResponse: Decodable {
    let data: [PostResponse]
    let nextCursor: String
    
    enum CodingKeys: String, CodingKey {
        case data
        case nextCursor = "next_cursor"
    }
}
//MARK: - Profile
struct ProfileResponse: Decodable {
    let posts: [String]
    let followers, following: [Follow]
    let id, email, nick, phoneNum: String
    let birthDay: String

    enum CodingKeys: String, CodingKey {
        case posts, followers, following
        case id = "_id"
        case email, nick, phoneNum, birthDay
    }
}

struct Follow: Decodable {
    let id, nick, profile: String
    
    enum CodingKeys: String, CodingKey {
        case id = "_id"
        case nick, profile
    }
}
