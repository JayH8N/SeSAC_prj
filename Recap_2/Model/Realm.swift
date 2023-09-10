//
//  Realm.swift
//  Recap_2
//
//  Created by hoon on 2023/09/10.
//

import UIKit
import RealmSwift

class Items: Object {
    
    @Persisted(primaryKey: true) var productId: String
    @Persisted var image: String
    @Persisted var mallName: String
    @Persisted var title: String
    @Persisted var lprice: String
    //@Persisted var liked: Bool

    convenience init(productId: String, image: String, mallName: String, title: String, lprice: String) {
        self.init()
        
        self.productId = productId
        self.image = image
        self.mallName = mallName
        self.title = title
        self.lprice = lprice
    }
}
