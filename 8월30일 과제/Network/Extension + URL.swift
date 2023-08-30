//
//  Extension + URL.swift
//  Diary
//
//  Created by hoon on 2023/08/30.
//

import UIKit

extension URL {
    static let baseUnsplash = "https://api.unsplash.com/"
    
    static func makeEndPoint(endPoint: String) -> String {
        return baseUnsplash + endPoint
    }
}
