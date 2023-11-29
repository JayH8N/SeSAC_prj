//
//  SetPersonalVC.swift
//  SeSACgram
//
//  Created by hoon on 11/27/23.
//

import UIKit

final class SetPersonalVC: BaseVC {
    
    private let tableViewData = SetPersonalSection.generateData()
    
    private let mainView = SetPersonalView()
    
    convenience init(title: String) {
        self.init()
        self.title = title
    }
    
    override func loadView() {
        self.view = mainView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        mainView.tableView.delegate = self
        mainView.tableView.dataSource = self
    }
    
    private func withdraw() {
        APIManager.shared.withdraw { [weak self] result in
            switch result {
            case .success( _):
                self?.transitionSignVC()
            case .failure(let error):
                if let error = error as? WithdrawError {
                    switch error {
                    case .expiredToken:
                        print("accessToken갱신합니다.")
                        APIManager.shared.updateToken { result in
                            switch result {
                            case .success(let value):
                                UserDefaultsHelper.shared.accessToken = value.token
                                APIManager.shared.withdraw { result in
                                    switch result {
                                    case .success( _):
                                        self?.transitionSignVC()
                                    case .failure(let error):
                                        if let error = error as? WithdrawError {
                                            print("\(error.errorDescription)")
                                        }
                                    }
                                }
                            case .failure(let error):
                                if let error = error as? TokenError {
                                    switch error {
                                    case .expiredRefreshToken:
                                        self?.showAlert1Button(title: "로그인세션 만료", message: "다시 로그인 후 탈퇴를 진행해주세요") { _ in
                                            self?.transitionSignVC()
                                        }
                                    default:
                                        print("\(error.errorDescription)")
                                    }
                                }
                            }
                        }
                    default:
                        print("\(error.errorDescription)")
                    }
                }
            }
        }
    }
    
    private func transitionSignVC() {
        UserDefaultsHelper.shared.isLogIn = false
        UserDefaultsHelper.shared.removeAccessToken()
        let vc = SignInVC()
        let nav = UINavigationController(rootViewController: vc)
        DispatchQueue.main.async {
            self.view?.window?.rootViewController = nav
            self.view.window?.makeKeyAndVisible()
        }
    }
}

extension SetPersonalVC: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return tableViewData.count
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tableViewData[section].items.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let target = tableViewData[indexPath.section].items[indexPath.row]
        
        let cell = tableView.dequeueReusableCell(withIdentifier: SetPersonalTableViewCell().description, for: indexPath) as! SetPersonalTableViewCell
        cell.setCell(data: target)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return tableViewData[section].header
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let target = tableViewData[indexPath.section].items[indexPath.row].title
        self.didSelect(title: target)
        tableView.reloadRows(at: [indexPath], with: .automatic)
    }
    
    private func didSelect(title: Menu.Setpersonal.RawValue) {
        switch title {
        case Menu.Setpersonal.logout.rawValue:
            UserDefaultsHelper.shared.isLogIn = false
            UserDefaultsHelper.shared.removeAccessToken()
            let vc = SignInVC()
            let nav = UINavigationController(rootViewController: vc)
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                self.view?.window?.rootViewController = nav
                self.view.window?.makeKeyAndVisible()
            }
        case Menu.Setpersonal.withdraw.rawValue:
            self.showAlert2Button(title: "정말 탈퇴하시겠어요?", message: "진짜??") { _ in
                self.withdraw()
            }
        default:
            break
        }
    }
}
