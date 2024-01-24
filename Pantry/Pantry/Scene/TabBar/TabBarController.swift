//
//  TabBarController.swift
//  Pantry
//
//  Created by hoon on 2023/09/25.
//

import UIKit

final class TabBarController: UITabBarController {
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureTabBar()
        
    }
    
}

extension TabBarController {
    
    private func configureTabBar() {
        tabBar.backgroundColor = UIColor.natural
        tabBar.tintColor = UIColor.white
        tabBar.unselectedItemTintColor = .darkGray
        
        //Home
        let home = templateNavigationController(image: "refrigerator", rootViewController: MainViewController(title: "Pantry"))
        
        //Search
        let searchTitle = NSLocalizedString("Search", comment: "")
        let search = templateNavigationController(image: "magnifyingglass.circle", rootViewController: SearchViewController(title: searchTitle))
        
        //Setting
        let settingTitle = NSLocalizedString("SettingTitle", comment: "")
        let setting = templateNavigationController(image: "gearshape", rootViewController: SettingVC(title: settingTitle))
        
        viewControllers = [home, search, setting]
    }
    
    private func templateNavigationController(image: String, rootViewController: UIViewController) -> UINavigationController {
        
        let nav = UINavigationController(rootViewController: rootViewController)
        
        nav.tabBarItem.title = ""
        nav.tabBarItem.image = UIImage(systemName: image)
        nav.tabBarItem.selectedImage = UIImage(systemName: "\(image).fill")
        
        return nav
    }
    
}
