//
//  SecondViewController.swift
//  BOOKWARM
//
//  Created by hoon on 2023/08/02.
//

import UIKit

class SecondViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        self.tabBarController?.tabBar.items![1].image = UIImage(systemName: "star.fill")
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
