//
//  Endpoint.swift
//  Diary
//
//  Created by hoon on 2023/08/30.
//

import UIKit


enum Endpoint {
    case search
    
    var callRequest: String {
        switch self {
        case .search : return URL.makeEndPoint(endPoint: "search/photos?query=")
        }
    }
}
