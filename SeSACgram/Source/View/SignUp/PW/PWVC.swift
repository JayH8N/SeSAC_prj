//
//  PWVC.swift
//  SeSACgram
//
//  Created by hoon on 11/15/23.
//

import UIKit
import RxSwift
import RxCocoa

final class PWVC: BaseVC {
    
    private let disposeBag = DisposeBag()
    
    private let mainView = PWView()
    
    override func loadView() {
        self.view = mainView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addTargets()
        self.hideKeyboardWhenTappedAround()
        bind()
    }
    
    private func bind() {
        
        let pwObservable = mainView.pwTextField.rx.text.orEmpty
        let pwCheckObservable = mainView.pwTextFieldCheck.rx.text.orEmpty
        
        let check = Observable.combineLatest(pwObservable, pwCheckObservable)
            .map { $0 == $1 && ($0.count != 0 && $1.count != 0) }
        
        check
            .map {isValid in
                self.mainView.nextButton.setBackgroundColor(isValid ? Constants.Color.DeepGreen : UIColor.gray, for: .normal)
                return isValid
            }
            .bind(to: mainView.nextButton.rx.isEnabled)
            .disposed(by: disposeBag)
    }
    
}

extension PWVC: AddTargetProtocol {
    func addTargets() {
        mainView.nextButton.addTarget(self, action: #selector(nextButtonTapped), for: .touchUpInside)
    }
    
    @objc private func nextButtonTapped() {
        let vc = NicknameVC()
        navigationController?.pushViewController(vc, animated: true)
    }
    
    
}
