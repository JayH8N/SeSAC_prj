//
//  BaseViewController.swift
//  Pantry
//
//  Created by hoon on 2023/09/25.
//

import UIKit

class BaseViewController: UIViewController {
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureView()
        setConstraints()
        setNavigationBar()
    }
    
    func setNavigationBar() { }
    
    func configureView() { }
    
    func setConstraints() { }
    
    func hideKeyboardWhenTappedAround() {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
    
    func showAlertView(title: String, message: String? = nil, handler: ((UIAlertAction) -> Void)? = nil) {
        
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        
        let ok = UIAlertAction(title: "확인", style: .default, handler: handler)
        let cancel = UIAlertAction(title: "No", style: .cancel)
        
        alert.addAction(ok)
        alert.addAction(cancel)
        
        present(alert, animated: true, completion: nil)
    }
    
    
}
