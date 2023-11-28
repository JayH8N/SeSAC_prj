//
//  ProfileVC.swift
//  SeSACgram
//
//  Created by hoon on 11/14/23.
//

import UIKit

final class ProfileVC: BaseVC {
    
    private let mainView = ProfileView()
    
    override func loadView() {
        self.view = mainView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addTargets()
    }
    
    override func setNavigationBar() {
        navigationItem.leftBarButtonItem = UIBarButtonItem(customView: mainView.nickNameLabel)
        navigationItem.rightBarButtonItem = UIBarButtonItem(customView: mainView.menuButton)
        
        let backButtonItem = UIBarButtonItem(title: "", style: .plain, target: self, action: nil)
        self.navigationItem.backBarButtonItem = backButtonItem
    }
    
    static func instance() -> ProfileVC {
        return ProfileVC(nibName: nil, bundle: nil)
    }
    
    deinit {
        print("====\(Self.self)====Deinit")
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
                                UserDefaultsHelper.shared.authenticationToken = value.token
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
        let vc = SignInVC()
        let nav = UINavigationController(rootViewController: vc)
        DispatchQueue.main.async {
            self.view?.window?.rootViewController = nav
            self.view.window?.makeKeyAndVisible()
        }
    }
}

extension ProfileVC: AddTargetProtocol {
    func addTargets() {
        mainView.withdrawButton.addTarget(self, action: #selector(withdrawButtonTapped), for: .touchUpInside)
        mainView.menuButton.addTarget(self, action: #selector(menuButtonTapped), for: .touchUpInside)
    }
    
    @objc private func withdrawButtonTapped() {
        self.showAlert2Button(title: "정말 탈퇴하시겠어요?", message: "진짜로???") { _ in
            self.withdraw()
        }
    }
    
    @objc private func menuButtonTapped() {
        let vc = BottomSheetVC.instance()
        vc.modalDelegate = self
        vc.pushDelegate = self
        addDim()
        present(vc, animated: true, completion: nil)
    }

}


//커스텀 모달
extension ProfileVC: ModalDelegate {
    func onTapClose() {
        self.removeDim()
    }
    
    private func addDim() {
        mainView.setModalBackView()
        DispatchQueue.main.async { [weak self] in
            self?.mainView.modalBackView.alpha = 0.2
        }
    }
    
    private func removeDim() {
        DispatchQueue.main.async { [weak self] in
            self?.mainView.modalBackView.removeFromSuperview()
        }
    }
}

//모달 dismiss후 push로 화면전환
extension ProfileVC: PushableTransition {
    func push(vc: UIViewController) {
        self.navigationController?.pushViewController(vc, animated: true)
    }
}
