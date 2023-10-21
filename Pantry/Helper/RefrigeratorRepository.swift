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
    
    //냉장고 가져오기
    func fetch() -> Results<Refrigerator> {
        var data = realm.objects(Refrigerator.self)
        return data
    }
    
    //냉장고 아이템 가져오기
    func fetchItem(rfObjectid: ObjectId) -> List<Items>? {
        if let refrigerator = realm.object(ofType: Refrigerator.self, forPrimaryKey: rfObjectid) {
            let items = refrigerator.ingredient
            return items
        }
        return nil
    }

//MARK: - 냉장고 관련메서드
    func createRefrigerator(_ rf: Refrigerator) {
        do {
            try! realm.write {
                realm.add(rf)
            }
        } catch {
            print(error)
        }
    }

    func removeRefrigerator(_ rf: Refrigerator) {
        do {
            try! realm.write {
                // 냉장고 이미지 파일 삭제
                let imageFileName = "JH\(rf._id)"
                DocumentManager.shared.removeImageFromDocument(fileName: imageFileName)

                for item in rf.ingredient {
                    let itemImageFileName = "JH\(item._id)"
                    DocumentManager.shared.removeImageFromDocument(fileName: itemImageFileName)
                }
                realm.delete(rf.ingredient)

                realm.delete(rf)
            }
        } catch {
            print(error)
        }
    }
    
    func updateRefrigerator(_ id: ObjectId, name: String, memo: String) {
        do {
            try realm.write {
                
                realm.create(Refrigerator.self, value: ["_id": id, "name": name, "memo": memo] as [String : Any], update: .modified)
            }
        } catch {
            print("") // NSlog
        }
    }
    
//MARK: - 냉장고 아이템관련 메서드
    //아이템 추가
    func addItemToRefrigerator(_ item: Items, refrigeratorId: ObjectId) {
        do {
            if let refrigerator = realm.object(ofType: Refrigerator.self, forPrimaryKey: refrigeratorId) {
                try realm.write {
                    refrigerator.ingredient.append(item)
                }
            } else {
                print("Error")
            }
        } catch {
            print(error)
        }
    }
    
    //아이템 삭제
    func removeItemFromRefrigerator(_ objectId: ObjectId) {
        do {
            if let item = realm.object(ofType: Items.self, forPrimaryKey: objectId) {
                try realm.write {
                    DocumentManager.shared.removeImageFromDocument(fileName: "JH\(objectId)")
                    realm.delete(item)
                }
            } else {
                print("Error")
            }
        } catch {
            print(error)
        }
    }
    
    //아이템 수정
    func updateItemFromRefrigerator(_ objectId: ObjectId, state: State.RawValue, name: String, count: Int, expiryDay: Date, memo: String?) {
        do {
            if let item = realm.object(ofType: Items.self, forPrimaryKey: objectId) {
                try realm.write {
                    item.state = state
                    item.name = name
                    item.count = count
                    item.expiryDay = expiryDay
                    item.memo = memo
                }
            } else {
                print("Error")
            }
        } catch {
            print(error)
        }
    }
    
}
