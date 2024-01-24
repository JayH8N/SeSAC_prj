//
//  ItemState.swift
//  Pantry
//
//  Created by hoon on 2023/10/22.
//

import Foundation
import RealmSwift

//냉장,냉동 상태
enum State: Int, PersistableEnum {
    case refrigeration = 0
    case frozen = 1
}
