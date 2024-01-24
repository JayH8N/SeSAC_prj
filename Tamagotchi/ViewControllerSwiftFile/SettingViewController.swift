//
//  SettingViewController.swift
//  Tamagotchi
//
//  Created by hoon on 2023/08/05.
//

import UIKit

class SettingViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    let list = ["내 이름 설정하기", "다마고치 변경하기", "데이터 초기화"]
    let imageName = ["pencil", "moon.fill", "arrow.clockwise"]

    @IBOutlet var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "설정"
        //self.navigationController?.navigationBar.topItem?.title = ""
        self.navigationController?.navigationBar.tintColor = fontColor
        self.setBackgroundColor()
        tableView.backgroundColor = themeColor
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.rowHeight = 48
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tableView.reloadData()
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: SettingTableViewCell.identifier) as! SettingTableViewCell
        
        let row = indexPath.row
        cell.backgroundColor = themeColor
        cell.leftImage.image = UIImage(systemName: imageName[row])
        cell.settingTitle.text = list[row]
        if row != 0 {
            cell.changedName.text = ""
        } else {
            cell.changedName.text = myName
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let row = indexPath.row
        
        if row == 0 {
//            let sb = UIStoryboard(name: "TamagotchiMain", bundle: nil)
//            let vc = sb.instantiateViewController(withIdentifier: NameChangeViewController.identifier) as! NameChangeViewController
//
//            navigationController?.pushViewController(vc, animated: true)
            
            transition(style: .push, sbName: "TamagotchiMain", viewController: NameChangeViewController.self, animate: true)
            
        } else if row == 1 {
            
            UserDefaults.standard.set(true, forKey: ForKey.changeCharacter.rawValue)
//            let sb = UIStoryboard(name: "Main", bundle: nil)
//            let vc = sb.instantiateViewController(withIdentifier: MainViewController.identifier) as! MainViewController
//
//            navigationController?.pushViewController(vc, animated: true)
            
            transition(style: .push, sbName: "Main", viewController: MainViewController.self, animate: true)
            
        } else {
            self.alert(title: "데이터초기화", message: "정말 다시 처음부터 시작하실 건가용?", handler: {action in self.reset()})
        }

        tableView.reloadRows(at: [indexPath], with: .none)
    }
    
    
    func reset() {
//        let sb = UIStoryboard(name: "Main", bundle: nil)
//        let vc = sb.instantiateViewController(withIdentifier: MainViewController.identifier) as! MainViewController
//
//
//        let nav = UINavigationController(rootViewController: vc)
//        nav.modalTransitionStyle = .crossDissolve
//        nav.modalPresentationStyle = .fullScreen
//
//        present(nav, animated: true)
        
        transition(style: .presentNavigation, sbName: "Main", viewController: MainViewController.self, PresentationStyle: .fullScreen, TransitionStyle: .crossDissolve, animate: true)
        
        
        
        for key in UserDefaults.standard.dictionaryRepresentation().keys {
                    UserDefaults.standard.removeObject(forKey: key.description)
                }
    }
}


extension SettingViewController: ReusableIdentifier {
    static var identifier: String {
        return String(describing: Self.self)
    }
}
