//
//  ProfileVC.swift
//  SeSACgram
//
//  Created by hoon on 11/14/23.
//

import UIKit

final class ProfileVC: BaseVC {
    
    let mainView = ProfileView()
    
    override func loadView() {
        self.view = mainView
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addTargets()
    }
    
    
    deinit {
        print("====\(Self.self)====Deinit")
    }
    
    private func withdraw() {
        APIManager.shared.withdraw { [weak self] result in
            switch result {
            case .success( _):
                let vc = SignInVC()
                vc.modalPresentationStyle = .fullScreen
                vc.modalTransitionStyle = .crossDissolve
                self?.present(vc, animated: true) {
                    vc.showByeToastMessage()
                }
            case .failure(let error):
                if let error = error as? WithdrawError {
                    switch error {
                    case .expiredToken:
                        print("accessToken갱신합니다.")
                        APIManager.shared.updateToken { result in
                            switch result {
                            case .success( _):
                                //UserDefaultsHelper.shared.authenticationToken = data.token
                                APIManager.shared.withdraw { result in
                                    switch result {
                                    case .success( _):
                                        let vc = SignInVC()
                                        vc.modalPresentationStyle = .fullScreen
                                        vc.modalTransitionStyle = .crossDissolve
                                        self?.present(vc, animated: true) {
                                            vc.showByeToastMessage()
                                        }
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
                                        self?.showAlert1Button(title: "로그인세션 만료", message: "로그인세션이 만료되었습니다.\n다시 로그인 해주세요!") { _ in
                                            let vc = SignInVC()
                                            vc.modalPresentationStyle = .fullScreen
                                            vc.modalTransitionStyle = .crossDissolve
                                            self?.present(vc, animated: true)
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
}

extension ProfileVC: AddTargetProtocol {
    func addTargets() {
        mainView.withdrawButton.addTarget(self, action: #selector(withdrawButtonTapped), for: .touchUpInside)
    }
    
    @objc private func withdrawButtonTapped() {
        self.showAlert2Button(title: "정말 탈퇴하시겠어요?", message: "진짜로???") { _ in
            self.withdraw()
        }
    }
}
