//
//  OnBoardingVC.swift
//  SeSAC_Talk
//
//  Created by hoon on 1/8/24.
//

import UIKit
import RxSwift
import RxCocoa

final class OnBoardingVC: BaseVC {
    
    private let mainView = OnBoardingView()
    private let disposeBag = DisposeBag()
    
    override func loadView() {
        self.view = mainView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        bind()
    }
    
    
}


extension OnBoardingVC {
    private func bind() {
        mainView.startButton
            .rx
            .tap
            .subscribe(with: self) { owner, _ in
                owner.createBottomSheet(vc: LoginBottomVC(), detent: .custom(260))
            }
            .disposed(by: disposeBag)
    }
}
