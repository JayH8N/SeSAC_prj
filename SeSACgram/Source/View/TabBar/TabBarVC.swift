//
//  TabBarVC.swift
//  SeSACgram
//
//  Created by hoon on 11/14/23.
//

import UIKit

final class TabBarVC: UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureTabBar()
        
        //Home
        let home = templateNavigationController(image: "Home", rootViewController: HomeVC())
        
        //Search
        let search = templateNavigationController(image: "Search", rootViewController: SearchVC())
        
        //Profile
        let profile = templateNavigationController(image: "Profile", rootViewController: ProfileVC())
        
        viewControllers = [home, search, profile]
    }
    
}

extension TabBarVC {
    
    private func configureTabBar() {
        tabBar.backgroundColor = Constants.CustomColor.Main
        tabBar.tintColor = UIColor.darkGray
        tabBar.unselectedItemTintColor = .darkGray
    }
    
    private func templateNavigationController(image: String, rootViewController: UIViewController) -> UINavigationController {
        
        let nav = UINavigationController(rootViewController: rootViewController)
        
        nav.tabBarItem.title = ""
        nav.tabBarItem.image = UIImage(named: image)
        nav.tabBarItem.selectedImage = UIImage(named: "\(image).fill")
        
        return nav
    }
    
}

