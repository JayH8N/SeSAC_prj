//
//  AppDelegate.swift
//  Tamagotchi
//
//  Created by hoon on 2023/08/04.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {



    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        //UIView.appearance().backgroundColor = UIColor(red: 245/255, green: 252/255, blue: 252/255, alpha: 1)
        UILabel.appearance().font = UIFont.systemFont(ofSize: 13)
        UILabel.appearance().textColor = fontColor
        UILabel.appearance().textAlignment = .center
        UINavigationBar.appearance().barTintColor = themeColor
//        UILabel.appearance().layer.cornerRadius = 15
//        UILabel.appearance().layer.borderWidth = 3
//        UILabel.appearance().layer.borderColor = UIColor(red: 77/255, green: 106/255, blue: 120/255, alpha: 1).cgColor
//        UIImageView.appearance().layer.borderColor = UIColor(red: 77/255, green: 106/255, blue: 120/255, alpha: 1).cgColor
//        UIImageView.appearance().layer.borderWidth = 3
//        UIImageView.appearance().layer.cornerRadius = 40
        
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

