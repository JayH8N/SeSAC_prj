//
//  Book.swift
//  BookWorm
//
//  Created by hoon on 2023/09/04.
//

import Foundation


struct KakaoBook: Codable {
    let documents: [BookInfo]
}

struct BookInfo: Codable {
    let authors: [String]
    let price: Int
    let thumbnail: String
    let title: String
}

