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
    
    @Persisted var posterImage: String
    @Persisted var bookTitle: String
    @Persisted var bookAuthor: String
    @Persisted var memo: String?
    @Persisted var set: String
    @Persisted var liked: Bool

    convenience init(posterURL: String, bookTitle: String, bookAuthor: String, memo: String?) {
        self.init()
        
        self.posterImage = posterURL
        self.bookTitle = bookTitle
        self.bookAuthor = bookAuthor
        self.memo = memo
        self.set = "\(bookTitle)의 저자는 \(bookAuthor)입니다."
    }
}

