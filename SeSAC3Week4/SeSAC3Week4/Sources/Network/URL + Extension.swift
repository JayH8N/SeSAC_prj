//
//  URL + Extension.swift
//  SeSAC3Week4
//
//  Created by hoon on 2023/08/11.
//

import Foundation

extension URL {
    static let baseURL = "https://dapi.kakao.com/v2/search/"
    
    static func makeEndPointStirng(_ endpoint: String) -> String {
        return baseURL + endpoint
    }
}
