//
//  SettingVC.swift
//  Pantry
//
//  Created by hoon on 12/18/23.
//

import UIKit
import SnapKit
import Then
import MessageUI
import Toast

final class SettingVC: BaseVC, MFMailComposeViewControllerDelegate {
    
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
    
    private func sendEmail() {
        if MFMailComposeViewController.canSendMail() {
            let composeViewController = MFMailComposeViewController()
            composeViewController.mailComposeDelegate = self
            
            let bodyString = """
                                -------------------
                                
                                Device Model : \(self.getDeviceIdentifier())
                                Device OS : \(UIDevice.current.systemVersion)
                                App Version : \(self.getCurrentVersion())
                                
                                -------------------
                                
                                * \(NSLocalizedString("feedback", comment: ""))
                                
                                """
            
            composeViewController.setToRecipients(["yoogoon919@gmail.com"])
            composeViewController.setSubject(NSLocalizedString("feedBackTitle", comment: ""))
            composeViewController.setMessageBody(bodyString, isHTML: false)
            
            self.present(composeViewController, animated: true, completion: nil)
        } else {
            print("메일 보내기 실패")
            let failEmail = NSLocalizedString("MailTransferFailed", comment: "")
            let failEmailMessage = NSLocalizedString("MailTransferFailedMessage", comment: "")
            let goAppStore = NSLocalizedString("GoAppStore", comment: "")
            
            let sendMailErrorAlert = UIAlertController(title: failEmail, message: failEmailMessage, preferredStyle: .alert)
            let goAppStoreAction = UIAlertAction(title: goAppStore, style: .default) { _ in
                // 앱스토어로 이동하기(Mail)
                if let url = URL(string: "https://apps.apple.com/kr/app/mail/id1108187098"), UIApplication.shared.canOpenURL(url) {
                    if #available(iOS 10.0, *) {
                        UIApplication.shared.open(url, options: [:], completionHandler: nil)
                    } else {
                        UIApplication.shared.openURL(url)
                    }
                }
            }
            let cancleAction = UIAlertAction(title: NSLocalizedString("Cancel", comment: ""), style: .destructive, handler: nil)
            
            sendMailErrorAlert.addAction(goAppStoreAction)
            sendMailErrorAlert.addAction(cancleAction)
            self.present(sendMailErrorAlert, animated: true, completion: nil)
        }
    }
    
    //메일보내면 작성창dismiss
    func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?) {
        self.dismiss(animated: true)
    }
    
    
    
    // Device Identifier 찾기
    private func getDeviceIdentifier() -> String {
        var systemInfo = utsname()
        uname(&systemInfo)
        let machineMirror = Mirror(reflecting: systemInfo.machine)
        let identifier = machineMirror.children.reduce("") { identifier, element in
            guard let value = element.value as? Int8, value != 0 else { return identifier }
            return identifier + String(UnicodeScalar(UInt8(value)))
        }
        
        return identifier
    }
    
    //현재 앱버전 가져오기
    private func getCurrentVersion() -> String {
        guard let dictionary = Bundle.main.infoDictionary,
              let version = dictionary["CFBundleShortVersionString"] as? String else { return "" }
        return version
    }
    
    //앱스토어 이동
    private func goToAppStoreForUpdate() {
        guard let appStoreURL = URL(string: "https://itunes.apple.com/app/6469016002") else {
            return
        }

        UIApplication.shared.open(appStoreURL, options: [:], completionHandler: nil)
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
        case NSLocalizedString(SettingMenu.MenuList.privacyPolicy.rawValue, comment: ""):
            let link = "https://sweet-baryonyx-eba.notion.site/3299bf21232041ed91f0d01bddf47ea5?pvs=4"
            let vc = NotionVC(link: link)
            navigationController?.pushViewController(vc, animated: true)
        case NSLocalizedString(SettingMenu.MenuList.contactUS.rawValue, comment: ""):
            self.sendEmail()
        case NSLocalizedString(SettingMenu.MenuList.openSource.rawValue, comment: ""):
            if let url = URL(string: UIApplication.openSettingsURLString) {
                UIApplication.shared.open(url)
            }
        case NSLocalizedString(SettingMenu.MenuList.appVersion.rawValue, comment: ""):
            ITunesAPIManager.shared.getLatestAppVersion { [weak self] latestVersion in
                if latestVersion == self?.getCurrentVersion() {
                    self?.view.makeToast(NSLocalizedString("LatestVersion", comment: ""), duration: 2.0, position: .center)
                } else {
                    let title = NSLocalizedString("updateTitle", comment: "")
                    let message = NSLocalizedString("updateMessage", comment: "")
                    self?.showAlertView(title: title, message: message) { _ in
                        self?.goToAppStoreForUpdate()
                    }
                }
            }
        default:
            break
        }
    }
}
