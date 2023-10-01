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
        tabBar.backgroundColor = .white
        tabBar.tintColor = UIColor.theme
        tabBar.unselectedItemTintColor = .darkGray
        
        //shadow
        tabBar.layer.shadowColor = UIColor.black.cgColor   //그림자 색깔
        tabBar.layer.shadowOffset = CGSize(width: 0, height: 0)  //태양이 보는 시점
        tabBar.layer.shadowRadius = 10  //그림자 코너깎임정도
        tabBar.layer.shadowOpacity = 0.5   //그림자 투명도
    }
    
    private func templateNavigationController(image: String, rootViewController: UIViewController) -> UINavigationController {
        
        let nav = UINavigationController(rootViewController: rootViewController)
        
        nav.tabBarItem.title = ""
        nav.tabBarItem.image = UIImage(systemName: image)
        nav.tabBarItem.selectedImage = UIImage(systemName: "\(image).fill")
        
        return nav
    }
    
    
    
}
