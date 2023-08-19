//
//  Extension + URL.swift
//  Media
//
//  Created by hoon on 2023/08/19.
//

import Foundation

extension URL {
    static let baseURL = "https://api.themoviedb.org/3/"
    
    static func makeEndPointString(_ endpoint: String) -> String {
        return baseURL + endpoint
    }
}
