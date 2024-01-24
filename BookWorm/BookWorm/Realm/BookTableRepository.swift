//
//  BookTableRepository.swift
//  BookWorm
//
//  Created by hoon on 2023/09/06.
//

import UIKit
import RealmSwift

enum Filter {
    case containSwift
    case existMemo
    case pinned
}

enum Sort {
    case added
    case sorted
    case reversed
}


final class BookTableRepository {
    
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
    
    func fetch(_ sort: Sort) -> Results<BookTable> {
        var data: Results<BookTable>
        
        switch sort {
        case .added:
            data = realm.objects(BookTable.self)
        case .sorted:
            data = realm.objects(BookTable.self).sorted(byKeyPath: "bookTitle", ascending: true)
        case .reversed:
            data = realm.objects(BookTable.self).sorted(byKeyPath: "bookTitle", ascending: false)
        }
        return data
    }
    
    func fetchFilter(kindOf: Filter) -> Results<BookTable> {
        let result = realm.objects(BookTable.self).where {
            switch kindOf {
            case .containSwift : return $0.bookTitle.contains("swift", options: .caseInsensitive) || $0.bookTitle.contains("스위프트")
            case .existMemo : return $0.memo != nil
            case .pinned : return $0.liked == true
            }
        }
        return result
    }
    
    func createItem(_ item: BookTable) {
        
        do {
            try! realm.write {
                realm.add(item)
            }
        } catch {
            print(error)
        }
    }
    
    func removeItem(_ item: BookTable) {
        
        do {
            try! realm.write {
                realm.delete(item)
            }
        } catch {
            print(error)
        }
    }
    
    func updateItem(id: ObjectId, memoText: String) {
        do {
            try realm.write {
                //realm.add(item, update: .modified)
                
                realm.create(BookTable.self, value: ["_id": id, "memo": memoText] as [String : Any], update: .modified) //=> 내가 원하는 컬럼값만 바꿀 수 있게 된다.
            }
        } catch {
            print("") // NSlog
        }
    }
    
    func updateLiked(id: ObjectId, liked: Bool) {
        do {
            try realm.write {
                realm.create(BookTable.self, value: ["_id": id, "liked": liked], update: .modified)
            }
        } catch {
            print("")
        }
    }
    
    
    
    
}
