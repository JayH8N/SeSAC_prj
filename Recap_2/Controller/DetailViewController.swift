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
    
        loadWebView()
        
        let appearanceTB = UITabBarAppearance()
        appearanceTB.backgroundColor = .black
        tabBarController?.tabBar.standardAppearance = appearanceTB
    }
    
    
    func loadWebView() {
        let myURL = URL(string: URL.naverShopURL + mainView.productID!)
        let myRequest = URLRequest(url: myURL!)
        mainView.webView.load(myRequest)
    }
    
    override func setNavigationBar() {
        navigationController?.navigationBar.tintColor = .white
        navigationItem.titleView = mainView.productTitle
        
        
        let appearanceNB = UINavigationBarAppearance()
        appearanceNB.backgroundColor = .black
        navigationController?.navigationBar.scrollEdgeAppearance = appearanceNB
        navigationController?.navigationBar.standardAppearance = appearanceNB
    }
    
    
    override func configureView() {

    }
    
    
    
    override func setConstraints() {
        
    }
    

    
}
