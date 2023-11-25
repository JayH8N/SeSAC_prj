//
//  BirthVC.swift
//  SeSACgram
//
//  Created by hoon on 11/15/23.
//

import UIKit
import Toast

final class BirthVC: BaseVC {
    
    private let mainView = BirthView()
    
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
    
    //회원가입 api
    private func signUp() {
        self?.navigationController?.popToRootViewController(animated: true) // <- 성공케이스일때 실행
    }
    
    private func transition() {
     
    }
}

extension BirthVC: AddTargetProtocol {
    func addTargets() {
        mainView.nextButton.addTarget(self, action: #selector(nextButtonTapped), for: .touchUpInside)
    }
    
    @objc private func nextButtonTapped() {
        let email = UserDefaultsHelper.shared.email
        let nickname = UserDefaultsHelper.shared.nickname
        let phone = UserDefaultsHelper.shared.phone ?? ""
        let birth = mainView.birthTextField.text ?? ""
        let userInfo: String = "이메일(ID) : \(email)\n닉네임 : \(nickname)\nTEL : \(phone)\n생일 : \(birth)"
        
        showAlertView(title: "가입하시겠습니까?", message: userInfo) { [weak self] _ in
            self?.signUp()
            
//            if let viewControllers = self?.navigationController?.viewControllers,
//               let firstViewController = viewControllers.first as? SignInVC {
//                firstViewController.showToastMessage()
//            }
        }
        
        
    }
}

