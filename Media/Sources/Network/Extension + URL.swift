//
//  Extension + URL.swift
//  Media
//
//  Created by hoon on 2023/08/19.
//

import Foundation

extension URL {
    static let baseURL = "https://api.themoviedb.org/3/"
    static let imageBaseURL = "https://image.tmdb.org/t/p/w500"
    static let emptyImage = "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTZc2ak60GYlraruLrL0csnJ4gS4CV30WNSvoPJLnqZEgiUY2ri-qOmoOuYQW2SKpqHAac&usqp=CAU"
    
    static func makeEndPointString(_ endpoint: String) -> String {
        return baseURL + endpoint
    }
}
