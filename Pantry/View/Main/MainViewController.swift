//
//  MainViewController.swift
//  Pantry
//
//  Created by hoon on 2023/09/25.
//

import UIKit


class MainViewController: BaseViewController {
    
    let mainView = MainView()
    
    override func loadView() {
        self.view = mainView
    }
    
    
    convenience init(title: String) {
        self.init()
        self.title = title
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
    }
    
    override func setNavigationBar() {
        self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.font: UIFont(name: "TiquiTaca-Regular", size: 30)!]
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(customView: mainView.addButton)
    }
    
    override func configureView() {
        mainView.addButton.addTarget(self, action: #selector(addButtonTapped), for: .touchUpInside)
    }
    
    
}

extension MainViewController {
    
    @objc func addButtonTapped() {
        let vc = addRefrigerViewController()
        let nav = UINavigationController(rootViewController: vc)
        
        present(nav, animated: true)
    }
}
