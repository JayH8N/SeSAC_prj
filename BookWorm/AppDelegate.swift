//
//  AppDelegate.swift
//  BookWorm
//
//  Created by hoon on 2023/09/04.
//

import UIKit
import RealmSwift

@main
class AppDelegate: UIResponder, UIApplicationDelegate {



    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        let config = Realm.Configuration(schemaVersion: 5) { migration, oldSchemaVersion in
        
            if oldSchemaVersion < 1 { }
            
            if oldSchemaVersion < 2 { }
            
            if oldSchemaVersion < 3 {
                migration.renameProperty(onType: BookTable.className() , from: "posterURL", to: "posterImage")
                //migration구문 적지 않아도 변경은 정상적으로 되지만 컬럼이 통채로 바뀌는 개념이되서 데이터 역시 모두 날라감
            }
            
            if oldSchemaVersion < 4 {
                migration.enumerateObjects(ofType: BookTable.className()) { oldObject, newObject in
                    guard let new = newObject else { return }
                    guard let old = oldObject else { return }
                    
                    new["set"] = "\(old["bookTitle"])의 저자는 \(old["bookAuthor"])입니다."
                }
                
            }
            
            if oldSchemaVersion < 5 { }
        }
        
        Realm.Configuration.defaultConfiguration = config
        
        return true
    }

    // MARK: UISceneSession Lifecycle

    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }


}

