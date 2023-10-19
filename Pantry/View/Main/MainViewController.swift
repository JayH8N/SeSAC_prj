//
//  MainViewController.swift
//  Pantry
//
//  Created by hoon on 2023/09/25.
//

import UIKit


class MainViewController: BaseViewController {
    
    let mainView = MainView()
    let repository = RefrigeratorRepository()
    
    
    override func loadView() {
        self.view = mainView
        
    }
    
    
    convenience init(title: String) {
        self.init()
        self.title = title
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        repository.realmPathCheck()
        
        mainView.stored = repository.fetch()
        print(mainView.stored)
        
        mainView.delegate = self
        
        
        NotificationCenter.default.addObserver(self, selector: #selector(reloadData), name: Notification.Name("ReloadData"), object: nil)
    }
    
    override func setNavigationBar() {
        self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.font: UIFont(name: "TAEBAEK milkyway", size: 30)!]
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(customView: mainView.addButton)
    }
    
    override func configureView() {
        mainView.addButton.addTarget(self, action: #selector(addButtonTapped), for: .touchUpInside)
        
    }
    
    
}

extension MainViewController {
    
    @objc func addButtonTapped() {
        let vc = AddViewController()
        let nav = UINavigationController(rootViewController: vc)
        
        present(nav, animated: true)
    }
    
    @objc func reloadData() {
        mainView.refrigerCollection.reloadData()
    }
}

extension MainViewController: NavPushProtocol {
    func pushView(vc: UIViewController) {
        navigationController?.pushViewController(vc, animated: true)
    }
}
