//
//  LoadingVC.swift
//  SeSACgram
//
//  Created by hoon on 11/27/23.
//

import UIKit

final class LoadingVC: BaseVC {
    
    private let mainView = LoadingView()
    
    override func loadView() {
        self.view = mainView
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
            self.mainView.indicator.startAnimating()
        }
    }
    
    
    deinit {
        mainView.indicator.stopAnimating()
        print("====\(Self.self)====Deinit")
    }
}
