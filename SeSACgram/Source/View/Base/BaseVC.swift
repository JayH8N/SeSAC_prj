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
        setNavigationBar()
        NotificationCenter.default.addObserver(self, selector: #selector(getReadToBackLogIn), name: Notification.Name.backToLogIn, object: nil)
    }
    
    func setNavigationBar() { }
    
    func configureView() { }
    
    func setConstraints() { }
    
    func hideKeyboardWhenTappedAround() {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        //tap.cancelsTouchesInView = false : 배경 뷰가 아닌 다른 뷰에서도 터치이벤트가 계속해서 전달되도록 함
        view.addGestureRecognizer(tap)
    }
    
    
    //Alert
    func showAlert2Button(title: String, message: String? = nil, handler: ((UIAlertAction) -> Void)? = nil) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        
        let ok = UIAlertAction(title: "확인", style: .default, handler: handler)
        let cancel = UIAlertAction(title: "취소", style: .default)
        ok.setValue(Constants.Color.DeepGreen, forKey: "titleTextColor")
        cancel.setValue(Constants.Color.DeepGreen, forKey: "titleTextColor")

        alert.addAction(cancel)
        alert.addAction(ok)
        
        present(alert, animated: true, completion: nil)
    }
    
    //Alert
    func showAlert1Button(title: String, message: String? = nil, handler: ((UIAlertAction) -> Void)? = nil) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        
        let ok = UIAlertAction(title: "확인", style: .default, handler: handler)
        ok.setValue(Constants.Color.DeepGreen, forKey: "titleTextColor")

        alert.addAction(ok)
        
        present(alert, animated: true, completion: nil)
    }
    
    @objc private func getReadToBackLogIn() {
        showAlert1Button(title: "로그인 세션 만료", message: "다시 로그인 해주세요") { [weak self] _ in
            self?.returnToLogIn()
        }
    }
    
    func returnToLogIn() {
        UserDefaultsHelper.shared.isLogIn = false
        UserDefaultsHelper.shared.removeAccessToken()
        DispatchQueue.main.async {
            let nav = UINavigationController(rootViewController: SignInVC())
            self.view?.window?.rootViewController = nav
            self.view.window?.makeKeyAndVisible()
        }
    }
}

extension BaseVC {
    @objc private func dismissKeyboard() {
        view.endEditing(true)
    }
}
