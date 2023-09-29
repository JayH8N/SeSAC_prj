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
        let homeTitle = NSLocalizedString("RefrigerTabBarTitle", comment: "")
        let home = templateNavigationController(tabBarTitle: homeTitle, image: "refrigerator", rootViewController: MainViewController(title: "Pantry"))
        
        //TabBar - search
        let searchTitle = NSLocalizedString("Search", comment: "")
        let search = templateNavigationController(tabBarTitle: searchTitle, image: "magnifyingglass.circle", rootViewController: SearchViewController(title: searchTitle))
        
        viewControllers = [home, search]
    }
    
}

extension TabBarController {
    
    private func configureTabBar() {
        tabBar.backgroundColor = .white
        tabBar.tintColor = UIColor.theme
        tabBar.unselectedItemTintColor = .darkGray
    }
    
    private func templateNavigationController(tabBarTitle: String, image: String, rootViewController: UIViewController) -> UINavigationController {
        
        let nav = UINavigationController(rootViewController: rootViewController)
        
        nav.tabBarItem.title = tabBarTitle
        nav.tabBarItem.image = UIImage(systemName: image)
        nav.tabBarItem.selectedImage = UIImage(systemName: "\(image).fill")
        
        return nav
    }
    
    
    
}
