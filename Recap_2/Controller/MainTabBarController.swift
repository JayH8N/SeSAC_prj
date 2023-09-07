//
//  MainTabBarController.swift
//  Recap_2
//
//  Created by hoon on 2023/09/07.
//

import UIKit

class MainTabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let first = UINavigationController.init(rootViewController: SearchViewController(title: "쇼핑 검색"))
        let second = UINavigationController.init(rootViewController: LikeViewController(title: "좋아요 목록"))
        setViewControllers([first, second], animated: true)
        
        let firstItem = UITabBarItem(title: "검색", image: UIImage(systemName: "magnifyingglass") , tag: 0)
        let secondItem = UITabBarItem(title: "좋아요", image: UIImage(systemName: "heart") , tag: 1)
        
        first.tabBarItem = firstItem
        second.tabBarItem = secondItem
        
        configureTabBar()
    }
}

extension MainTabBarController {
    func configureTabBar() {
        tabBar.tintColor = .white
        tabBar.unselectedItemTintColor = .darkGray
    }
}
