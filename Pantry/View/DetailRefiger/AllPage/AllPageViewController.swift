//
//  AllPageViewController.swift
//  Pantry
//
//  Created by hoon on 2023/10/09.
//

import UIKit
import BarcodeScanner

class AllPageViewController: BaseViewController {
    
    
    let mainView = AllPageView()
    
    override func loadView() {
        view = mainView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        mainView.switchDelegate = self
        mainView.delegate = self
    }
    
    
    override func configureView() {
        
    }
    
    override func setConstraints() {
        
    }
    
    
}

extension AllPageViewController: SwitchScreenProtocol, didSelectProtocol {
    func pushView(vc: UIViewController) {
        navigationController?.pushViewController(vc, animated: true)
    }
    
    func switchScreen(nav: UINavigationController) {
        present(nav, animated: true)
    }
    
    
}
