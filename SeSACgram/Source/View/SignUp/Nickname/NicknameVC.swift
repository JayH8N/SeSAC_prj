//
//  NicknameVC.swift
//  SeSACgram
//
//  Created by hoon on 11/15/23.
//

import Foundation


final class NicknameVC: BaseVC {
    
    private let mainView = NicknameView()
    
    override func loadView() {
        self.view = mainView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.hideKeyboardWhenTappedAround()
        addTargets()
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
