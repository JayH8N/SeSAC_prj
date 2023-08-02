//
//  ThirdViewController.swift
//  BOOKWARM
//
//  Created by hoon on 2023/08/02.
//

import UIKit

class ThirdViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        self.tabBarController?.tabBar.items![2].image = UIImage(systemName: "star.fill")
    }
    


}
