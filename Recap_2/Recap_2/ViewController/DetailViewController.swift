//
//  DetailViewController.swift
//  Recap_2
//
//  Created by hoon on 2023/09/09.
//

import UIKit


final class DetailViewController: BaseViewController {
    
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
        
        mainView.setNavigationBarlikeButton()
        
        print("====\(mainView.deliveryValue)====") //값전달 확인
    }
    
    
    private func loadWebView() {
        let myURL = URL(string: URL.naverShopURL + mainView.deliveryValue.productId)
        let myRequest = URLRequest(url: myURL!)
        mainView.webView.load(myRequest)
    }
    
    override func setNavigationBar() {
        navigationController?.navigationBar.tintColor = .white
        navigationItem.titleView = mainView.productTitle
        
        //네비게이션바 appearance
        let appearanceNB = UINavigationBarAppearance()
        appearanceNB.backgroundColor = .black
        navigationController?.navigationBar.scrollEdgeAppearance = appearanceNB
        navigationController?.navigationBar.standardAppearance = appearanceNB
        
        
        let likeButton = UIBarButtonItem(customView: mainView.likeButton)
        navigationItem.rightBarButtonItem = likeButton
    }
    
    
    
    

    
}
