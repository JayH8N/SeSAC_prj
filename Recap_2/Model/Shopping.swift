//
//  Shopping.swift
//  Recap_2
//
//  Created by hoon on 2023/09/09.
//

import UIKit


struct Shopping: Codable {
    let total, start, display: Int
    let items: [Item]
}

struct Item: Codable {
    let mallName, lprice, title, image: String
}
