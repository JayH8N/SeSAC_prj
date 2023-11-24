//
//  EmailVC.swift
//  SeSACgram
//
//  Created by hoon on 11/15/23.
//

import UIKit
import RxSwift
import RxCocoa

final class EmailVC: BaseVC {
    
    private let disposeBag = DisposeBag()
    
    
    private let mainView = EmailView()
    
    override func loadView() {
        self.view = mainView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.hideKeyboardWhenTappedAround()
        addTargets()
        bindEmailTextField()
    }
    
    
    private func bindEmailTextField() {
        mainView.emailTextField
            .rx
            .text
            .orEmpty
            .debounce(RxTimeInterval.seconds(1), scheduler: MainScheduler.instance)
            .distinctUntilChanged()
            .subscribe(with: self) { owner, value in
                if !value.isEmpty {
                    owner.checkingEmail(email: value)
                }
            }
            .disposed(by: disposeBag)

        let isTextFieldEmpty = mainView
            .emailTextField
            .rx
            .text
            .orEmpty
            .map { $0.count == 0 }

        isTextFieldEmpty
            .bind { [weak self] isEmpty in
                self?.mainView.nextButton.isEnabled = !isEmpty
                self?.mainView.nextButton.setBackgroundColor(UIColor.gray, for: .normal)
                self?.mainView.emailTextField.tintColor = Constants.Color.DeepGreen
                self?.mainView.emailTextField.rightButton.tintColor = Constants.Color.DeepGreen
                self?.mainView.failMessage.isHidden = true
            }
            .disposed(by: disposeBag)
    }

    
    private func checkingEmail(email: String) {
        let isValidEmail = email.contains("@") && (email.contains(".com") || email.contains(".net"))
        
        if isValidEmail {
            APIManager.shared.checkEmail(email: email) { result in
                switch result {
                case .success( _):
                    self.mainView.nextButton.isEnabled = true
                    self.mainView.nextButton.setBackgroundColor(Constants.Color.DeepGreen, for: .normal)
                    self.mainView.failMessage.isHidden = true
                    self.mainView.emailTextField.layer.borderColor = Constants.Color.DeepGreen.cgColor
                    self.mainView.emailTextField.tintColor = Constants.Color.DeepGreen
                    self.mainView.emailTextField.rightButton.tintColor = Constants.Color.DeepGreen
                case .failure( _):
                    self.mainView.nextButton.isEnabled = false
                    self.mainView.nextButton.backgroundColor = UIColor.gray
                    self.mainView.failMessage.isHidden = false
                    self.mainView.emailTextField.layer.borderColor = UIColor.red.cgColor
                    self.mainView.failMessage.isHidden = false
                    self.mainView.emailTextField.tintColor = UIColor.red
                    self.mainView.emailTextField.rightButton.tintColor = UIColor.red
                }
            }
        } else {
            // 이메일이 조건에 맞지 않으면 실패 케이스 처리
            self.mainView.nextButton.isEnabled = false
            self.mainView.nextButton.backgroundColor = UIColor.gray
            self.mainView.failMessage.isHidden = false
            self.mainView.emailTextField.layer.borderColor = UIColor.red.cgColor
            self.mainView.failMessage.isHidden = false
            self.mainView.emailTextField.tintColor = UIColor.red
            self.mainView.emailTextField.rightButton.tintColor = UIColor.red
        }
    }
}
    


extension EmailVC: AddTargetProtocol {
    func addTargets() {
        mainView.nextButton.addTarget(self, action: #selector(nextButtonTapped), for: .touchUpInside)
    }
    
    @objc private func nextButtonTapped() {
        let vc = PWVC()
        navigationController?.pushViewController(vc, animated: true)
    }
}
