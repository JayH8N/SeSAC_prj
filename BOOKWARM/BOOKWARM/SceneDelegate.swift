//
//  SceneDelegate.swift
//  BOOKWARM
//
//  Created by hoon on 2023/07/31.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    
    var window: UIWindow?
    
    
    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        
        if let tbc = self.window?.rootViewController as? UITabBarController {
            
            // 현재 선택된 아이템 색깔 지정
            tbc.tabBar.tintColor = .blue
            
            // 탭바의 색깔
            tbc.tabBar.barTintColor = .systemGray5

            if let tbItems = tbc.tabBar.items {
                            tbItems[0].image = UIImage(systemName: "star.fill")
                            tbItems[1].image = UIImage(systemName: "star.fill")
                            tbItems[2].image = UIImage(systemName: "star.fill")
                            
                            tbItems[0].title = "둘러보기"
                            tbItems[1].title = ""
                            tbItems[2].title = ""
                                
                            }
            
//            // 탭바 아이템
//            tbc.tabBar.items?[0] = UITabBarItem(title: "둘러보기", image: UIImage(systemName: "star"), selectedImage: UIImage(systemName: "star.fill"))
//            tbc.tabBar.items?[1] = UITabBarItem(title: "", image: UIImage(systemName: "star"), selectedImage: UIImage(systemName: "star.fill"))
//            tbc.tabBar.items?[2] = UITabBarItem(title: "", image: UIImage(systemName: "star"), selectedImage: UIImage(systemName: "star.fill"))
        }
        
        guard let _ = (scene as? UIWindowScene) else { return }
    }
    
    
    
    
    func sceneDidDisconnect(_ scene: UIScene) {
        // Called as the scene is being released by the system.
        // This occurs shortly after the scene enters the background, or when its session is discarded.
        // Release any resources associated with this scene that can be re-created the next time the scene connects.
        // The scene may re-connect later, as its session was not necessarily discarded (see `application:didDiscardSceneSessions` instead).
    }
    
    func sceneDidBecomeActive(_ scene: UIScene) {
        // Called when the scene has moved from an inactive state to an active state.
        // Use this method to restart any tasks that were paused (or not yet started) when the scene was inactive.
    }
    
    func sceneWillResignActive(_ scene: UIScene) {
        // Called when the scene will move from an active state to an inactive state.
        // This may occur due to temporary interruptions (ex. an incoming phone call).
    }
    
    func sceneWillEnterForeground(_ scene: UIScene) {
        // Called as the scene transitions from the background to the foreground.
        // Use this method to undo the changes made on entering the background.
    }
    
    func sceneDidEnterBackground(_ scene: UIScene) {
        // Called as the scene transitions from the foreground to the background.
        // Use this method to save data, release shared resources, and store enough scene-specific state information
        // to restore the scene back to its current state.
    }
    
    
}

