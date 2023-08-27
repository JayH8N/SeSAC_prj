//
//  TV_Videos.swift
//  Media
//
//  Created by hoon on 2023/08/21.
//

import Foundation

// MARK: - Backdrop
struct Backdrop: Codable {
    let backdrops: [BackdropElement]
    let id: Int
    let logos, posters: [BackdropElement]
}

// MARK: - BackdropElement
struct BackdropElement: Codable {
    let aspectRatio: Double
    let height: Int
    let iso639_1: String?
    let filePath: String
    let voteAverage: Double
    let voteCount, width: Int

    enum CodingKeys: String, CodingKey {
        case aspectRatio = "aspect_ratio"
        case height
        case iso639_1 = "iso_639_1"
        case filePath = "file_path"
        case voteAverage = "vote_average"
        case voteCount = "vote_count"
        case width
    }
}
