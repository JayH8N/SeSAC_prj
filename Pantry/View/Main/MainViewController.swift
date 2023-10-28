//
//  MainViewController.swift
//  Pantry
//
//  Created by hoon on 2023/09/25.
//

import UIKit
import UserNotifications

final class MainViewController: BaseViewController {
    
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
        
        let backButtonItem = UIBarButtonItem(title: "", style: .plain, target: self, action: nil)
        self.navigationItem.backBarButtonItem = backButtonItem
        
        //등록된 알람 현황 확인
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
        
        //UserDefaults로 저장한 알람 리스트(Dictionary)
        print("알람 리스트 : \(LocalNotificationManager.shared.infoList)")
    }
    
    
    override func setNavigationBar() {
        self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.font: UIFont(name: "TAEBAEK milkyway", size: 30)!]
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(customView: mainView.addButton)
        navigationItem.leftBarButtonItem = UIBarButtonItem(customView: mainView.alarmButton)
    }
    
    override func configureView() {
        mainView.addButton.addTarget(self, action: #selector(addButtonTapped), for: .touchUpInside)
        mainView.alarmButton.addTarget(self, action: #selector(alarmButtonTapped), for: .touchUpInside)
    }
    
    
}

extension MainViewController {
    
    @objc private func addButtonTapped() {
        let vc = AddViewController()
        let nav = UINavigationController(rootViewController: vc)
        
        present(nav, animated: true)
    }
    
    @objc private func alarmButtonTapped() {
        let vc = AlarmStatusViewController(title: NSLocalizedString("Alarm", comment: ""))
        
        navigationController?.pushViewController(vc, animated: true)
    }
    
    @objc private func reloadData() {
        mainView.refrigerCollection.reloadData()
    }
}

extension MainViewController: NavPushProtocol {
    func pushView(vc: UIViewController) {
        navigationController?.pushViewController(vc, animated: true)
    }
}
