//
//  Endpoint.swift
//  PhotoGram
//
//  Created by hoon on 2023/08/30.
//

import Foundation

enum Endpoint {
    case search
    
    var callRequest: String {
        switch self {
        case .search : return URL.makeEndPoint(endPoint: "search/photos?per_page=100&query=")
        }
    }
}
