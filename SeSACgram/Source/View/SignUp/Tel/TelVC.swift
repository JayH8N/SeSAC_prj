//
//  TelVC.swift
//  SeSACgram
//
//  Created by hoon on 11/15/23.
//

import UIKit
import RxSwift
import RxCocoa

final class TelVC: BaseVC {
    
    private let disposeBag = DisposeBag()
    private let mainView = TelView()
    
    private let phone = PublishSubject<String>()
    
    override func loadView() {
        self.view = mainView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.hideKeyboardWhenTappedAround()
        addTargets()
        bind()
        mainView.telTextField.delegate = self
    }
    
    deinit {
        print("====\(Self.self)====Deinit")
    }
    
    private func bind() {
        phone
            .bind(to: mainView.telTextField.rx.text)
            .disposed(by: disposeBag)
        
        let isValid = mainView.telTextField
            .rx
            .text
            .orEmpty
            .map { $0.count == 0 || $0.count == 13}
        
        isValid
            .subscribe(with: self) { owner, value in
                owner.updateUI(isValid: value)
                
                if value && owner.mainView.telTextField.text?.count == 13 {
                    owner.mainView.nextButton.setTitle("다음", for: .normal)
                } else {
                    owner.mainView.nextButton.setTitle("건너뛰기", for: .normal)
                }
            }
            .disposed(by: disposeBag)
        
        mainView.telTextField
            .rx
            .text
            .orEmpty
            .subscribe(with: self) { owner, value in
                let result = value.formated(by: "###-####-####")
                owner.phone.onNext(result)
            }
            .disposed(by: disposeBag)
    }
    
    private func updateUI(isValid: Bool) {
        mainView.nextButton.isEnabled = isValid
        mainView.nextButton.setBackgroundColor(isValid ? Constants.Color.DeepGreen : UIColor.gray, for: .normal)
    }


}

extension TelVC: AddTargetProtocol {
    func addTargets() {
        mainView.nextButton.addTarget(self, action: #selector(nextButtonTapped), for: .touchUpInside)
    }
    
    @objc private func nextButtonTapped() {
        UserDefaultsHelper.shared.phone = mainView.telTextField.text
        let vc = BirthVC()
        navigationController?.pushViewController(vc, animated: true)
    }
}

extension TelVC: UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let textFieldText = mainView.telTextField.text ?? ""
        let inputString = (textFieldText as NSString).replacingCharacters(in: range, with: string)
        
        if inputString.count <= mainView.numLimit {
            return true
        } else {
            return false
        }
    }
}
