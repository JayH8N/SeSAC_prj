//
//  DetailView.swift
//  Recap_2
//
//  Created by hoon on 2023/09/09.
//

import UIKit
import MarqueeLabel
import WebKit


class DetailView: BaseView, WKUIDelegate {
    
    
    var productID: String?
    var title: String?
    
    lazy var productTitle = {
        let view = MarqueeLabel()
        view.text = title!
        view.fadeLength = 10
        view.textColor = .white
        view.widthAnchor.constraint(equalToConstant: 200).isActive = true
        return view
    }()
    
    lazy var webView = {
        var view = WKWebView()
        view.uiDelegate = self
        let webConfiguration = WKWebViewConfiguration()
        view = WKWebView(frame: .zero, configuration: webConfiguration)
        return view
    }()
    
    
    
    override func configureView() {
        addSubview(webView)
    }
    
    
    override func setConstraints() {
        webView.snp.makeConstraints { make in
            make.edges.equalTo(self.safeAreaLayoutGuide)
        }
    }
    
    
    
    
}
