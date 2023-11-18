//
//  BaseVC.swift
//  SeSACgram
//
//  Created by hoon on 11/15/23.
//

import UIKit

class BaseVC: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureView()
        setConstraints()
    }
    
    
    func configureView() { }
    
    func setConstraints() { }
    
    func hideKeyboardWhenTappedAround() {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        //tap.cancelsTouchesInView = false : 배경 뷰가 아닌 다른 뷰에서도 터치이벤트가 계속해서 전달되도록 함
        view.addGestureRecognizer(tap)
    }
}

extension BaseVC {
    @objc private func dismissKeyboard() {
        view.endEditing(true)
    }
}
