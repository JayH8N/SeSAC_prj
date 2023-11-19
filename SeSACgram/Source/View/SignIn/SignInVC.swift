//
//  SignInVC.swift
//  SeSACgram
//
//  Created by hoon on 11/14/23.
//

import UIKit

final class SignInVC: BaseVC {
    
    private let mainView = SignInView()
    
    
    override func loadView() {
        self.view = mainView
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.hideKeyboardWhenTappedAround()
        addTargets()
    }

    deinit {
        print("====\(Self.self)====Deinit")
    }
    
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
        //로그인 API호출
    }
    @objc private func signUPButtonTapped() {
        let vc = EmailVC()
        navigationController?.pushViewController(vc, animated: true)
    }
}
