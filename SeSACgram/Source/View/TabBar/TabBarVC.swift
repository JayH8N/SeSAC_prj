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
        let home = templateNavigationController(image: Constants.Image.TabBarHome,
                                                rootViewController: HomeVC())
        
        //Search
        let search = templateNavigationController(image: Constants.Image.TabBarSearch,
                                                  rootViewController: SearchVC())
        
        //Profile
        let profile = templateNavigationController(image: Constants.Image.TabBarProfile,
                                                   rootViewController: ProfileVC())
        
        viewControllers = [home, search, profile]
    }
    
}

extension TabBarVC {
    
    private func configureTabBar() {
        tabBar.backgroundColor = Constants.Color.Appearance
        tabBar.tintColor = Constants.Color.DeepGreen
        tabBar.unselectedItemTintColor = Constants.Color.DeepGreen
    }
    
    private func templateNavigationController(image: String, rootViewController: UIViewController) -> UINavigationController {
        
        let nav = UINavigationController(rootViewController: rootViewController)
        
        nav.tabBarItem.title = ""
        nav.tabBarItem.image = UIImage(named: image)
        nav.tabBarItem.selectedImage = UIImage(named: "\(image).fill")
        
        return nav
    }
    
}

