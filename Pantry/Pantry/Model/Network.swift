//
//  Network.swift
//  Pantry
//
//  Created by hoon on 2023/10/23.
//

import Foundation

struct ProductInfo: Decodable {
    let C005: ProductData
}

struct ProductData: Decodable {
    let row: [Product]
    let RESULT: ResultData
}

struct Product: Decodable {
    let PRDLST_NM: String
    let POG_DAYCNT: String
}

struct ResultData: Decodable {
    let CODE: String
    let MSG: String
}
