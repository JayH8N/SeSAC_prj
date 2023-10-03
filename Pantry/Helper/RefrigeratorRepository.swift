//
//  RefrigeratorRepository.swift
//  Pantry
//
//  Created by hoon on 2023/10/03.
//

import UIKit
import RealmSwift


class RefrigeratorRepository {
    
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
    
    func createItem(_ item: Refrigerator) {
        do {
            try! realm.write {
                realm.add(item)
            }
        } catch {
            print(error)
        }
    }
    
    func removeItem(_ item: Refrigerator) {
        do {
            try! realm.write {
                realm.delete(item)
            }
        } catch {
            print(error)
        }
    }
    

}
