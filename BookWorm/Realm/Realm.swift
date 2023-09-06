//
//  Realm.swift
//  BookWorm
//
//  Created by hoon on 2023/09/04.
//

import UIKit
import RealmSwift

class BookTable: Object {
    
    @Persisted(primaryKey: true) var _id: ObjectId //
    
    @Persisted var posterURL: String
    @Persisted var bookTitle: String
    @Persisted var bookAuthor: String
    @Persisted var memo: String?

    convenience init(posterURL: String, bookTitle: String, bookAuthor: String, memo: String?) {
        self.init()
        
        self.posterURL = posterURL
        self.bookTitle = bookTitle
        self.bookAuthor = bookAuthor
        self.memo = memo
    }
}

