//
//  NaverShoppingRepository.swift
//  Recap_2
//
//  Created by hoon on 2023/09/10.
//

import UIKit
import RealmSwift
 
class NaverShoppingRepository {
    
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
    
    func fetch() -> Results<Items> {
        var data = realm.objects(Items.self)
        
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
    
    
}
