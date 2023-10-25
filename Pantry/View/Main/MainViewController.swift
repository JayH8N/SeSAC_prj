//
//  MainViewController.swift
//  Pantry
//
//  Created by hoon on 2023/09/25.
//

import UIKit
import UserNotifications

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
        
        mainView.delegate = self
        
        
        NotificationCenter.default.addObserver(self, selector: #selector(reloadData), name: Notification.Name("RefrigerReloadData"), object: nil)
        
        
        
        //+++++++++++++++++++알람 확인=======================++++++++++++++++++++++=========
        UNUserNotificationCenter.current().getPendingNotificationRequests { notificationRequests in
            for request in notificationRequests {
                let identifier = request.identifier
                let content = request.content
                let trigger = request.trigger
                print("알람 식별자: \(identifier)")
                print("알람 내용: \(content)")
                print("알람 트리거: \(trigger))")
            }
        }
        
        print(LocalNotificationManager.shared.infoList)
        

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
