//
//  Cast.swift
//  Media
//
//  Created by hoon on 2023/08/20.
//

import UIKit

// MARK: - Cast
struct Cast: Codable {
    let id: Int
    let cast, crew: [CastElement]
}

// MARK: - CastElement
struct CastElement: Codable {
    let adult: Bool
    let gender, id: Int
    let knownForDepartment, name, originalName: String
    let popularity: Double
    let profilePath: String?
    let castID: Int?
    let character: String?
    let creditID: String
    let order: Int?
    let department, job: String?

    enum CodingKeys: String, CodingKey {
        case adult, gender, id
        case knownForDepartment = "known_for_department"
        case name
        case originalName = "original_name"
        case popularity
        case profilePath = "profile_path"
        case castID = "cast_id"
        case character
        case creditID = "credit_id"
        case order, department, job
    }
}
