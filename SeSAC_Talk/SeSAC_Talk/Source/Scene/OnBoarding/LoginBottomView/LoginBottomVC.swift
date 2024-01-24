//
//  LoginBottomVC.swift
//  SeSAC_Talk
//
//  Created by hoon on 1/8/24.
//

import UIKit
import RxSwift
import RxCocoa

final class LoginBottomVC: BaseVC {
    
    private let mainView = LoginBottomView()
    private let disposeBag = DisposeBag()
    
    override func loadView() {
        self.view = mainView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        bind()
    }
    
}

extension LoginBottomVC {
    enum LoginType {
        case apple, kakao, email, signUp
    }
    
    private func bind() {
        mainView.apple
            .rx
            .tap
            .subscribe(with: self) { owner, _ in
                owner.handleLoginTap(.apple)
            }
            .disposed(by: disposeBag)
        
        mainView.kakao
            .rx
            .tap
            .subscribe(with: self) { owner, _ in
                owner.handleLoginTap(.kakao)
            }
            .disposed(by: disposeBag)
        
        mainView.email
            .rx
            .tap
            .subscribe(with: self) { owner, _ in
                owner.handleLoginTap(.email)
            }
            .disposed(by: disposeBag)
        
        let labelTapGesture = UITapGestureRecognizer(target: self, action: #selector(signUpButtonClicked))
        mainView.signUPLabel.addGestureRecognizer(labelTapGesture)
        
    }
    
    @objc private func signUpButtonClicked() {
        self.handleLoginTap(.signUp)
    }
    
    private func handleLoginTap(_ type: LoginType) {
        switch type {
        case .apple:
            print("Apple 로그인")
        case .kakao:
            print("카카오 로그인")
        case .email:
            print("이메일로 로그인")
        case .signUp:
            print("회원가입")
        }
    }
}
