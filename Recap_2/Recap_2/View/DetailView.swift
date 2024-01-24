//
//  DetailView.swift
//  Recap_2
//
//  Created by hoon on 2023/09/09.
//

import UIKit
import MarqueeLabel
import WebKit


final class DetailView: BaseView, WKUIDelegate {
    
    let repository = NaverShoppingRepository()
    
    var deliveryValue = Items(productId: "", image: "", mallName: "", title: "", lprice: "")
    
    
    lazy var productTitle = {
        let view = MarqueeLabel()
        view.text = deliveryValue.title.replacingOccurrences(of: "</b>", with: "").replacingOccurrences(of: "<b>", with: "")
        view.fadeLength = 10
        view.textColor = .white
        view.widthAnchor.constraint(equalToConstant: 150).isActive = true
        return view
    }()
    
    lazy var webView = {
        var view = WKWebView()
        view.uiDelegate = self
        let webConfiguration = WKWebViewConfiguration()
        view = WKWebView(frame: .zero, configuration: webConfiguration)
        return view
    }()
    
    let likeButton = {
        let view = UIButton()
        view.tintColor = .white
        return view
    }()
    
    
    override func configureView() {
        addSubview(webView)
        likeButton.addTarget(self, action: #selector(likeButtonTapped), for: .touchUpInside)
    }
    
    
    override func setConstraints() {
        webView.snp.makeConstraints { make in
            make.edges.equalTo(self.safeAreaLayoutGuide)
        }
    }
    
    @objc func likeButtonTapped(_ sender: UIButton) {
        
        if let isExist = repository.isLikeFilter(data: deliveryValue.productId) {
            DocumentManager.shared.removeImageFromDocument(fileName: "JH\(deliveryValue.productId)")
            
            repository.removeItem(isExist)
            
            sender.setButtonImage(size: 30, systemName: "heart")
        } else {
            let task = self.deliveryValue
            
            print("하..ㅠㅠ")
            
//            repository.createItem(task)
            
            
//            DispatchQueue.global().async {
//                self.repository.createItem(task)
//                if let url = URL(string: task.image), let data = try? Data(contentsOf: url) {
//                    DispatchQueue.main.async {
//                        DocumentManager.shared.saveImageToDocument(fileName: "JH\(task.productId)", image: UIImage(data: data)!)
//                        sender.setButtonImage(size: 30, systemName: "heart.fill")
//                    }
//                }
//            }
            //⚠️Realm DB작업은 비동기로..
        }
        
        
    }
    
    
    
    
    //DB에 존재하면 heart.fill 아니라면 heart
    func setNavigationBarlikeButton() {
        if repository.isLikeFilter(data: deliveryValue.productId) != nil {
            likeButton.setButtonImage(size: 30, systemName: "heart.fill")
        } else {
            likeButton.setButtonImage(size: 30, systemName: "heart")
        }
    }
    
    
    
    
    
}
