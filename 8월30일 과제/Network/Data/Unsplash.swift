//
//  Unsplash.swift
//  PhotoGram
//
//  Created by hoon on 2023/09/01.
//

import Foundation

struct Photo: Codable {
    let total: Int
    let total_pages: Int
    let results: [PhotoResult]
}

struct PhotoResult: Codable {
    let id: String
    let urls: PhotoURL                 //배열의 형태가 아닌것 주의
}

struct PhotoURL: Codable {
    let full: String
    let thumb: String
}
