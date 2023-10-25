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
        let data = realm.objects(Refrigerator.self)
        return data
    }
    
    func fetchItems() -> Results<Items> {
        let data = realm.objects(Items.self).sorted(byKeyPath: "registDay", ascending: false)
        return data
    }
    
    //냉장고 아이템 가져오기
    func fetch(_ sort: Sort, rfObjectid: ObjectId) -> Results<Items>? {
        guard let refrigerator = realm.object(ofType: Refrigerator.self, forPrimaryKey: rfObjectid) else {
            return nil
        }
        
        let currentDate = Date()
        let basicDate = Calendar.current.date(byAdding: .day, value: -1, to: currentDate)

        switch sort {
        case .Added:
            return refrigerator.ingredient.sorted(byKeyPath: "registDay", ascending: false)
        case .ExpFastest:
            return refrigerator.ingredient.sorted(byKeyPath: "expiryDay", ascending: true)
        case .ExpSlowest:
            return refrigerator.ingredient.sorted(byKeyPath: "expiryDay", ascending: false)
        case .ExpiredGoods:
            return refrigerator.ingredient.filter("expiryDay < %@", basicDate).sorted(byKeyPath: "expiryDay", ascending: true)
        }
    }
    
    //냉장고 아이템 중 냉장, 냉동 구분하여 받아오기
    func fetchItemsInRefrigerator(_ rfObjectid: ObjectId, state: State, sort: Sort) -> Results<Items>? {
        if let refrigerator = realm.object(ofType: Refrigerator.self, forPrimaryKey: rfObjectid) {
            let itemsWithState = refrigerator.ingredient.filter("state == %@", state.rawValue)

            switch sort {
            case .Added:
                return itemsWithState.sorted(byKeyPath: "registDay", ascending: false)
            case .ExpFastest:
                return itemsWithState.sorted(byKeyPath: "expiryDay", ascending: true)
            case .ExpSlowest:
                return itemsWithState.sorted(byKeyPath: "expiryDay", ascending: false)
            case .ExpiredGoods:
                let currentDate = Date()
                let basicDate = Calendar.current.date(byAdding: .day, value: -1, to: currentDate)
                return itemsWithState.filter("expiryDay < %@", basicDate).sorted(byKeyPath: "expiryDay", ascending: true)
            }
        }
        return nil
    }
    
    //냉장고 아이템 냉장, 냉동 아이템 개수
    func itemCountForState(in rfObjectid: ObjectId, state: State) -> Int {
        guard let refrigerator = realm.object(ofType: Refrigerator.self, forPrimaryKey: rfObjectid) else {
            return 0
        }
        
        let items = refrigerator.ingredient.filter { $0.state == state.rawValue }

        return items.count
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
                    LocalNotificationManager.shared.removeNotification(item: item)
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
    
    //아이템 검색
    func searchTitle(text: String) -> Results<Items> {
        let results = realm.objects(Items.self).where {
            $0.name.contains(text, options: .caseInsensitive)
        }
        return results
    }
    
}
