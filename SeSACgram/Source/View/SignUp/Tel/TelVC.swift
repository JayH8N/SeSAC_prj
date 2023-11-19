//
//  TelVC.swift
//  SeSACgram
//
//  Created by hoon on 11/15/23.
//

import UIKit


final class TelVC: BaseVC {
    
    private let mainView = TelView()
    
    override func loadView() {
        self.view = mainView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.hideKeyboardWhenTappedAround()
        addTargets()
    }

}

extension TelVC: AddTargetProtocol {
    func addTargets() {
        mainView.nextButton.addTarget(self, action: #selector(nextButtonTapped), for: .touchUpInside)
    }
    
    @objc private func nextButtonTapped() {
        let vc = BirthVC()
        navigationController?.pushViewController(vc, animated: true)
    }
}
