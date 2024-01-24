//
//  Endpoint.swift
//  SeSAC3Week4
//
//  Created by hoon on 2023/08/11.
//

import Foundation

enum Endpoint {
    case blog
    case cafe
    case video
    
    var requestURL: String {
        switch self {
        case .blog: return URL.makeEndPointStirng("blog?query=")
        case .cafe: return URL.makeEndPointStirng("cafe?query=")
        case .video: return URL.makeEndPointStirng("vclip?query=")
        }
    }
}
