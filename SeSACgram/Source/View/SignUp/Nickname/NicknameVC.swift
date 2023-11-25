//
//  NicknameVC.swift
//  SeSACgram
//
//  Created by hoon on 11/15/23.
//

import UIKit
import RxSwift
import RxCocoa

final class NicknameVC: BaseVC {
    
    private let disposeBag = DisposeBag()
    
    private let mainView = NicknameView()
    
    override func loadView() {
        self.view = mainView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.hideKeyboardWhenTappedAround()
        addTargets()
        bind()
    }
    
    private func bind() {
        let isTextFieldEmpty = mainView.nickNameTextField
            .rx
            .text
            .orEmpty
            .map { $0.count != 0 }
        
        isTextFieldEmpty
            .bind(to: mainView.nextButton.rx.isEnabled)
            .disposed(by: disposeBag)

        isTextFieldEmpty
            .map { isValid in
                isValid ? Constants.Color.DeepGreen : UIColor.gray
            }
            .subscribe(with: self, onNext: { owner, value in
                owner.mainView.nextButton.setBackgroundColor(value, for: .normal)
            })
            .disposed(by: disposeBag)
    }

    
    
}

extension NicknameVC: AddTargetProtocol {
    func addTargets() {
        mainView.nextButton.addTarget(self, action: #selector(nextButtonTapped), for: .touchUpInside)
    }
    
    @objc private func nextButtonTapped() {
        let vc = TelVC()
        navigationController?.pushViewController(vc, animated: true)
    }
}
