//
//  BaseViewController.swift
//  Pantry
//
//  Created by hoon on 2023/09/25.
//

import UIKit

class BaseVC: UIViewController {
    
    
    
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
        
        let okTitle = NSLocalizedString("Apply", comment: "")
        let cancelTitle = NSLocalizedString("Cancel", comment: "")
        
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        
        let ok = UIAlertAction(title: okTitle, style: .default, handler: handler)
        let cancel = UIAlertAction(title: cancelTitle, style: .default)
        
        alert.addAction(cancel)
        alert.addAction(ok)
        
        present(alert, animated: true, completion: nil)
    }
    
}
