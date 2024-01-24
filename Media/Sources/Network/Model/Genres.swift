//
//  Movie_jenres.swift
//  Media
//
//  Created by hoon on 2023/08/19.
//

import UIKit

// MARK: - MovieGenres
struct Genres: Codable {
    let genres: [Genre]
}

// MARK: - Genre
struct Genre: Codable {
    let id: Int
    let name: String
}
