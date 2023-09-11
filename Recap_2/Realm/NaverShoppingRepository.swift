//
//  NaverShoppingRepository.swift
//  Recap_2
//
//  Created by hoon on 2023/09/10.
//

import UIKit
import RealmSwift
 
final class NaverShoppingRepository {
    
    private let realm = try! Realm()
    
    //realm파일경로
    func realmPathCheck() {
        print(realm.configuration.fileURL)
    }
    
    //스키마버전 체크 메서드
    func checkSchemaVersion() {
        do {
            let version = try schemaVersionAtURL(realm.configuration.fileURL!)
            print("Schema Version: \(version)")
        } catch {
            print(error)
        }
    }
    
    
    //실시간 검색필터
    func searchTitle(text: String) -> Results<Items> {
        let results = realm.objects(Items.self).where {
             $0.title.contains(text, options: .caseInsensitive)
        }
        return results
    }
    
    //Db존재여부
    func isLikeFilter(data: String) -> Items? {
        let exist = realm.object(ofType: Items.self, forPrimaryKey: data)

        return exist
    }
    
    
    
    
    
    func fetch() -> Results<Items> {
        let data = realm.objects(Items.self).sorted(byKeyPath: "_id", ascending: false)
        
        return data
    }
    
    func createItem(_ item: Items) {
        
        do {
            try! realm.write {
                realm.add(item)
            }
        } catch {
            print(error)
        }
    }
    
    func removeItem(_ item: Items) {
        
        do {
            try! realm.write {
                realm.delete(item)
            }
        } catch {
            print(error)
        }
    }
    
    
    func updateItem(id: String, liked: Bool) {
        do {
            try realm.write {
                realm.create(Items.self, value: ["productId": id, "liked": liked], update: .modified)
            }
        } catch {
            print("")
        }
    }
    
}
