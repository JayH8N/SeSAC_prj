//
//  BirthVC.swift
//  SeSACgram
//
//  Created by hoon on 11/15/23.
//

import Foundation


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
}

extension BirthVC: AddTargetProtocol {
    func addTargets() {
        
    }
    
    @objc private func nextButtonTapped() {
        
    }
}

