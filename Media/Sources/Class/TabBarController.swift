//
//  TabBarController.swift
//  Media
//
//  Created by hoon on 2023/08/25.
//

import UIKit

class TabBarController: UITabBarController, UITabBarControllerDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()
        delegate = self

    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        let sb1 = UIStoryboard(name: "Main", bundle: nil)
        let vc1 = sb1.instantiateViewController(withIdentifier: MainViewController.identifier) as! MainViewController
        
        let sb2 = UIStoryboard(name: "Main", bundle: nil)
        let vc2 = sb2.instantiateViewController(withIdentifier: TVMainViewController.identifier) as! TVMainViewController
        
        let vc3 = ProfileViewController()
      
        let tabOne = UINavigationController(rootViewController: vc1)
        let tabOneBarItem = UITabBarItem(title: "Movie", image: UIImage(systemName: "popcorn"), tag: 1)
        tabOne.tabBarItem = tabOneBarItem
        
        let tabTwo = UINavigationController(rootViewController: vc2)
        let tabTwoBarItem = UITabBarItem(title: "TVSeries", image: UIImage(systemName: "tv"), tag: 2)
        tabTwo.tabBarItem = tabTwoBarItem
        
        let tabThird = UINavigationController(rootViewController: vc3)
        let tabThirdBarItem = UITabBarItem(title: "Profile", image: UIImage(systemName: "person.crop.circle"), tag: 3)
        tabThird.tabBarItem = tabThirdBarItem
        
        self.viewControllers = [tabOne, tabTwo, tabThird]
        
        
    }
    
}
