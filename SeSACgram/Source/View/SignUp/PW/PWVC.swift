//
//  PWVC.swift
//  SeSACgram
//
//  Created by hoon on 11/15/23.
//

import UIKit

final class PWVC: BaseVC {
    
    private let mainView = PWView()
    
    override func loadView() {
        self.view = mainView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addTargets()
        self.hideKeyboardWhenTappedAround()
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
