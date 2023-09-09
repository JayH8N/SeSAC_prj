//
//  DetailViewController.swift
//  Recap_2
//
//  Created by hoon on 2023/09/09.
//

import UIKit


class DetailViewController: BaseViewController {
    
    let mainView = DetailView()
    
    override func loadView() {
        view = mainView
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let myURL = URL(string: URL.naverShopURL + mainView.productID!)
        let myRequest = URLRequest(url: myURL!)
        mainView.webView.load(myRequest)
    }
    
    override func setNavigationBar() {
        navigationController?.navigationBar.tintColor = .white
        navigationItem.titleView = mainView.productTitle
    }
    
    
    override func configureView() {
        
    }
    
    
    
    override func setConstraints() {
        
    }
    

    
}
