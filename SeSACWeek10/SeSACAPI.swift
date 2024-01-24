//
//  SeSACAPI.swift
//  SeSAC3Week10
//
//  Created by hoon on 2023/09/19.
//

import Foundation
import Alamofire


enum SeSACAPI {
    
    private static let key = "6nPfsQZkioJ50yzd1lKkqH3Kdg8UgoiAXae3wxX8FNo"
    
    case search(query: String)
    case random
    case photo(id: String) //연관값
    
    private var baseURL: String {
        return "https://api.unsplash.com/"
    }
    
    var endPoint: URL {
        switch self {
        case .search:
            return URL(string: baseURL + "search/photos")!
        case .random:
            return URL(string: baseURL + "photos/random")!
        case .photo(let id):
            return URL(string: baseURL + "photos/\(id)")! //id가 그때그때마다 달라짐 => 연관값 사용
        }
    }
    
    var header: HTTPHeaders {
        return ["Authorization": "Client-ID \(SeSACAPI.key)"]
    }
    
    var method: HTTPMethod {
        return .get
    }
    
    var qeury: [String: String] {
        switch self {
        case .search(let query):
            return ["query": query]
        case .random, .photo:
            return ["": ""]
        }
    }
    
    
    
}
