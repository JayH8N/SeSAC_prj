//
//  SettingVC.swift
//  Pantry
//
//  Created by hoon on 12/18/23.
//

import UIKit
import SnapKit
import Then

final class SettingVC: BaseVC {
    
    private let tableviewData = SetSettingSection.generateData()
    
    private let mainView = SettingView()
    
    override func loadView() {
        self.view = mainView
    }
    
    convenience init(title: String) {
        self.init()
        self.title = title
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        mainView.tableView.delegate = self
        mainView.tableView.dataSource = self
    }
    
    override func setNavigationBar() {
        let appearance = UINavigationBarAppearance()
        appearance.backgroundColor = UIColor.natural
        navigationController?.navigationBar.scrollEdgeAppearance = appearance
        navigationController?.navigationBar.standardAppearance = appearance
    }
    
    
}

extension SettingVC: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return tableviewData.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tableviewData[section].items.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let target = tableviewData[indexPath.section].items[indexPath.row]
        
        let cell = tableView.dequeueReusableCell(withIdentifier: SettingCell().description, for: indexPath) as! SettingCell
        cell.setCell(data: target)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return tableviewData[section].header
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let target = tableviewData[indexPath.section].items[indexPath.row].title
        self.didSelect(title: target)
        tableView.reloadRows(at: [indexPath], with: .automatic)
    }
    
    private func didSelect(title: String) {
        switch title {
        case NSLocalizedString(SettingMenu.MenuList.notificationSetting.rawValue, comment: ""):
            print("알림설정")
        case NSLocalizedString(SettingMenu.MenuList.privacyPolicy.rawValue, comment: ""):
            let link = "https://sweet-baryonyx-eba.notion.site/3299bf21232041ed91f0d01bddf47ea5?pvs=4"
            let vc = NotionVC(link: link)
            navigationController?.pushViewController(vc, animated: true)
        case NSLocalizedString(SettingMenu.MenuList.contactUS.rawValue, comment: ""):
            print("문의하기")
        case NSLocalizedString(SettingMenu.MenuList.openSource.rawValue, comment: ""):
            print("오픈소스")
        case NSLocalizedString(SettingMenu.MenuList.appVersion.rawValue, comment: ""):
            print("앱버전")
        default:
            break
        }
    }
    
}
