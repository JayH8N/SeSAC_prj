//
//  Book.swift
//  BookWorm
//
//  Created by hoon on 2023/09/04.
//

import Foundation


struct KakaoBook: Codable {
    let documents: [Results]
}

struct Results: Codable {
    let authors: [String]
    let price: Int
    let thumbnail: String
    let title: String
}

//struct Meta: Codable {
//    let is_end: Bool
//    let pageable_count: Int
//    let total_count: Int
//}
