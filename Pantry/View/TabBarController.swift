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
        
        //TabBar - home
        let home = templateNavigationController(image: "refrigerator", rootViewController: MainViewController(title: "Pantry"))
        
        //TabBar - search
        let searchTitle = NSLocalizedString("Search", comment: "")
        let search = templateNavigationController(image: "magnifyingglass.circle", rootViewController: SearchViewController(title: searchTitle))
        
        viewControllers = [home, search]
    }
    
}

extension TabBarController {
    
    private func configureTabBar() {
        tabBar.backgroundColor = UIColor.natural
        tabBar.tintColor = UIColor.white
        tabBar.unselectedItemTintColor = .darkGray
        
    }
    
    private func templateNavigationController(image: String, rootViewController: UIViewController) -> UINavigationController {
        
        let nav = UINavigationController(rootViewController: rootViewController)
        
        nav.tabBarItem.title = ""
        nav.tabBarItem.image = UIImage(systemName: image)
        nav.tabBarItem.selectedImage = UIImage(systemName: "\(image).fill")
        
        return nav
    }
    
    
    
    
    
    
    
}
