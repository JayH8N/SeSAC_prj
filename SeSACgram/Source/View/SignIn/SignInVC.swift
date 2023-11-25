//
//  SignInVC.swift
//  SeSACgram
//
//  Created by hoon on 11/14/23.
//

import UIKit
import RxSwift
import RxCocoa
import Toast

final class SignInVC: BaseVC {
    
    private let disposeBag = DisposeBag()
    private let mainView = SignInView()
    
    override func loadView() {
        self.view = mainView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.hideKeyboardWhenTappedAround()
        addTargets()
//        showToastMessage()
    }

    deinit {
        print("====\(Self.self)====Deinit")
    }
    
//    func showToastMessage() {
//        self.view.makeToast("회원가입을 축하드립니다", duration: 2.0, position: .center)
//        self.view.makeToast("dddddd")
//    }
    
}

extension SignInVC: AddTargetProtocol {
    func addTargets() {
        mainView.signInButton.addTarget(self,
                                        action: #selector(signInButtonTapped),
                                        for: .touchUpInside)
        mainView.signUpButton.addTarget(self,
                                        action: #selector(signUPButtonTapped),
                                        for: .touchUpInside)
    }
    
    @objc private func signInButtonTapped() {
        let email = mainView.emailTextField.text ?? ""
        let pw = mainView.pwTextField.text ?? ""
        let data = LogIn(email: email, password: pw)
        APIManager.shared.login(data: data) { result in
            switch result {
            case .success( _):
                let vc = TabBarVC()
                vc.modalPresentationStyle = .fullScreen
                vc.modalTransitionStyle = .crossDissolve
                self.present(vc, animated: true)
            case .failure(let failure):
                if let error = failure as? LogInError {
                    switch error {
                    case .requiredValueMissing:
                        self.showAlert1Button(title: "필수값을 채워주세요")
                    case .unsubscribe:
                        self.showAlert1Button(title: "미가입 또는 비밀번호 불일치입니다.")
                    }
                }
            }
        }
    }
    @objc private func signUPButtonTapped() {
        let vc = EmailVC()
        navigationController?.pushViewController(vc, animated: true)
    }
}
