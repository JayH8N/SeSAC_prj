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
    
    
//    private func bindEmailTextField() {
//        mainView.emailTextField
//            .rx
//            .text
//            .orEmpty
//            .debounce(RxTimeInterval.seconds(1), scheduler: MainScheduler.instance)
//            .distinctUntilChanged()
//            .subscribe(with: self) { owner, value in
//                if !value.isEmpty {
//                    owner.checkingEmail(email: value)
//                }
//            }
//            .disposed(by: disposeBag)
//        
//        let isTextFieldEmpty = mainView
//            .emailTextField
//            .rx
//            .text
//            .orEmpty
//            .map { $0.count == 0 }
//        
//        isTextFieldEmpty
//            .map { isValid in
//                
//                return isValid
//            }
//            .bind { [weak self] isEmpty in
//                self?.mainView.nextButton.isEnabled = !isEmpty
//                self?.mainView.nextButton.setBackgroundColor(UIColor.gray, for: .normal)
//                self?.mainView.emailTextField.tintColor = Constants.Color.DeepGreen
//                self?.mainView.emailTextField.rightButton.tintColor = Constants.Color.DeepGreen
//                self?.mainView.failMessage.isHidden = true
//            }
//            .disposed(by: disposeBag)
//    }
//    
//    
//    private func checkingEmail(email: String) {
//        
//        APIManager.shared.checkEmail(email: email) { result in
//            switch result {
//            case .success( _):
//                self.mainView.nextButton.isEnabled = true
//                self.mainView.nextButton.setBackgroundColor(Constants.Color.DeepGreen, for: .normal)
//                self.mainView.failMessage.isHidden = true
//                self.mainView.emailTextField.layer.borderColor = Constants.Color.DeepGreen.cgColor
//                self.mainView.emailTextField.tintColor = Constants.Color.DeepGreen
//                self.mainView.emailTextField.rightButton.tintColor = Constants.Color.DeepGreen
//                
//                //이벤트 전달 -> true
//            case .failure( _):
//                self.mainView.nextButton.isEnabled = false
//                self.mainView.nextButton.backgroundColor = UIColor.gray
//                self.mainView.failMessage.isHidden = false
//                self.mainView.emailTextField.layer.borderColor = UIColor.red.cgColor
//                self.mainView.failMessage.isHidden = false
//                self.mainView.emailTextField.tintColor = UIColor.red
//                self.mainView.emailTextField.rightButton.tintColor = UIColor.red
//                
//                //이벤트 전달 -> false
//            }
//        }
//    }
    
    private func bindEmailTextField() {
        let isValid = PublishSubject<Bool>()
        
        mainView.emailTextField
            .rx
            .text
            .orEmpty
            .debounce(RxTimeInterval.seconds(1), scheduler: MainScheduler.instance)
            .distinctUntilChanged()
            .subscribe(with: self) { owner, value in
                if !value.isEmpty {
                    owner.checkingEmail(email: value, isValidSubject: isValid)
                }
            }
            .disposed(by: disposeBag)
        
        let isTextFieldEmpty = mainView.emailTextField
            .rx
            .text
            .orEmpty
            .map { $0.count == 0 }
        
        isTextFieldEmpty
            .bind { [weak self] isEmpty in
                
                if isEmpty {
                    self?.mainView.nextButton.isEnabled = !isEmpty
                    self?.mainView.nextButton.setBackgroundColor(UIColor.gray, for: .normal)
                    self?.mainView.emailTextField.tintColor = Constants.Color.DeepGreen
                    self?.mainView.emailTextField.rightButton.tintColor = Constants.Color.DeepGreen
                    self?.mainView.emailTextField.layer.borderColor = Constants.Color.DeepGreen.cgColor
                    self?.mainView.failMessage.isHidden = isEmpty
                }
            }
            .disposed(by: disposeBag)

        

        isValid
            .bind { [weak self] isValid in
                guard let self = self else { return }
                
                if self.mainView.emailTextField.text!.isEmpty {
                    // 텍스트가 빈 문자열인 경우 UI 초기화
                    self.mainView.nextButton.isEnabled = false
                    self.mainView.nextButton.setBackgroundColor(UIColor.gray, for: .normal)
                    self.mainView.emailTextField.tintColor = Constants.Color.DeepGreen
                    self.mainView.emailTextField.rightButton.tintColor = Constants.Color.DeepGreen
                    self.mainView.emailTextField.layer.borderColor = Constants.Color.DeepGreen.cgColor
                    self.mainView.failMessage.isHidden = true
                } else {
                    // 텍스트가 빈 문자열이 아닌 경우에 대한 UI 업데이트
                    self.mainView.nextButton.isEnabled = isValid
                    self.mainView.nextButton.setBackgroundColor(isValid ? Constants.Color.DeepGreen : UIColor.gray, for: .normal)
                    self.mainView.emailTextField.tintColor = isValid ? Constants.Color.DeepGreen : UIColor.red
                    self.mainView.emailTextField.rightButton.tintColor = isValid ? Constants.Color.DeepGreen : UIColor.red
                    self.mainView.emailTextField.layer.borderColor = isValid ? Constants.Color.DeepGreen.cgColor : UIColor.red.cgColor
                    self.mainView.failMessage.isHidden = isValid
                }
            }
            .disposed(by: disposeBag)
    }

    private func checkingEmail(email: String, isValidSubject: PublishSubject<Bool>) {
        
        guard !email.isEmpty else {
            isValidSubject.onNext(false)
            return
        }
        APIManager.shared.checkEmail(email: email) { result in
            switch result {
            case .success:
                isValidSubject.onNext(true)
            case .failure:
                isValidSubject.onNext(false)
            }
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
