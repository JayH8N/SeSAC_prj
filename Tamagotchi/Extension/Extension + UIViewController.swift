//
//  Extension + UIViewController.swift
//  Tamagotchi
//
//  Created by hoon on 2023/08/17.
//

import UIKit

extension UIViewController {
    
    enum TransitionStyle {
        case present //네이게이션 없이 present
        case presentNavigation //네이베이션 임베드 된 present
        case push
    }
    

    
    func setBackgroundColor() {
        view.backgroundColor = themeColor
    }
    
    func alert(title: String, message: String? = nil, handler: ((UIAlertAction) -> Void)? = nil) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        
        let ok = UIAlertAction(title: "Yes", style: .default, handler: handler)
        let cancel = UIAlertAction(title: "No", style: .default)
        alert.addAction(cancel)
        alert.addAction(ok)
        
        present(alert, animated: true)
    }
    
    func alertOnly1Button(title: String) {
        let alert = UIAlertController(title: title, message: nil, preferredStyle: .alert)
        
        let ok = UIAlertAction(title: "확인", style: .default)
        alert.addAction(ok)
        
        present(alert, animated: true)
    }
    
    
    //화면전환
    func transition<T: UIViewController>(style: TransitionStyle, sbName: String, viewController: T.Type, PresentationStyle: UIModalPresentationStyle? = nil, TransitionStyle: UIModalTransitionStyle? = nil, animate: Bool) {
        
        
        let sb = UIStoryboard(name: sbName, bundle: nil)
        guard let vc = sb.instantiateViewController(withIdentifier: String(describing: viewController)) as?  T  else { return }
        
        
        switch style {
        case .present:
            vc.modalPresentationStyle = PresentationStyle ?? .automatic
            present(vc, animated: animate)
        case .presentNavigation:
            let nav = UINavigationController(rootViewController: vc)
            nav.modalTransitionStyle = TransitionStyle ?? .coverVertical
            nav.modalPresentationStyle = PresentationStyle ?? .automatic
            present(nav, animated: animate)
        case .push:
            navigationController?.pushViewController(vc, animated: animate)
        }
    }

    
    
}
