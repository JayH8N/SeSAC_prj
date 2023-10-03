//
//  Realm.swift
//  Pantry
//
//  Created by hoon on 2023/09/25.
//

import Foundation
import RealmSwift

//냉장,냉동 상태
enum State: Int, PersistableEnum {
    case refrigeration
    case frozen
}



class Refrigerator: Object {
   @Persisted(primaryKey: true) var _id: ObjectId
   @Persisted var photo: Data?
   @Persisted var name: String
   @Persisted var memo: String?
   @Persisted var ingredient: List<Items>



    convenience init(photo: Data?,
                     name: String,
                     memo: String?) {

       self.init()
       self.name = name
       self.memo = memo
   }
}



class Items: Object {
    @Persisted(primaryKey: true) var _id: ObjectId
    @Persisted var photo: Data?
    @Persisted var state: State
    @Persisted var name: String
    @Persisted var count: Int
    @Persisted var registDay: Date
    @Persisted var expiryDay: Date
    @Persisted var memo: String?

    @Persisted(originProperty: "ingredient") var mainFridge: LinkingObjects<Refrigerator> //역관계 정의

    convenience init(photo: Data?,
                     state: State,
                     name: String,
                     count: Int,
                     registDay: Date,
                     expiryDay: Date,
                     memo: String?) {

        self.init()
        self.photo = photo
        self.state = state
        self.name = name
        self.count = count
        self.registDay = registDay
        self.expiryDay = expiryDay
        self.memo = memo
    }
}
