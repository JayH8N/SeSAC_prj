//
//  TabBarVC.swift
//  SeSACgram
//
//  Created by hoon on 11/14/23.
//

import UIKit
import SnapKit
import Then

final class TabBarVC: UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureTabBar()
        addPostButton()
    }
    
}

extension TabBarVC {
    
    private func configureTabBar() {
        tabBar.backgroundColor = Constants.Color.Appearance
        tabBar.tintColor = Constants.Color.DeepGreen
        tabBar.unselectedItemTintColor = Constants.Color.DeepGreen
        
        //Home
        let homePosition = UIOffset(horizontal: -30, vertical: 0)
        let home = templateNavigationController(image: Constants.Image.TabBarHome,
                                                rootViewController: HomeVC(), titlePositionAdjustment: homePosition)
        
        
        //Search
//        let search = templateNavigationController(image: Constants.Image.TabBarSearch,
//                                                  rootViewController: SearchVC())
        
        //Profile
        let profilePosition = UIOffset(horizontal: 30, vertical: 0)
        let profile = templateNavigationController(image: Constants.Image.TabBarProfile,
                                                   rootViewController: ProfileVC(), titlePositionAdjustment: profilePosition)
        
        viewControllers = [home, profile]
    }
    
    private func templateNavigationController(image: String, rootViewController: UIViewController, titlePositionAdjustment: UIOffset = UIOffset(horizontal: 0, vertical: 0)) -> UINavigationController {
        
        let nav = UINavigationController(rootViewController: rootViewController)
        
        nav.tabBarItem.title = ""
        nav.tabBarItem.image = UIImage(named: image)
        nav.tabBarItem.selectedImage = UIImage(named: "\(image).fill")
        nav.tabBarItem.titlePositionAdjustment = titlePositionAdjustment
        
        return nav
    }
    
    private func addPostButton() {
        let action = UIAction(title: "") { [weak self] _ in
            HapticManager.shared.viberateForInteraction(style: .light)
            let vc = PostVC()
            let nav = UINavigationController(rootViewController: vc)
            nav.modalPresentationStyle = .fullScreen
            self?.present(nav, animated: true)
        }
        
        let postButton = UIButton(primaryAction: action).then {
            $0.tintColor = Constants.Color.DeepGreen
            $0.backgroundColor = .clear
            $0.setButtonImage(size: 40, systemName: Constants.Image.Post, state: .normal)
            $0.setButtonImage(size: 40, systemName: Constants.Image.PostFill, state: .highlighted)
        }
        view.addSubview(postButton)
        postButton.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.bottom.equalToSuperview().offset(-38)
            $0.size.equalTo(50)
        }
    }
    
}
