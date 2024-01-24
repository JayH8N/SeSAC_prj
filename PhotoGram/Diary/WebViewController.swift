//
//  WebViewController.swift
//  Diary
//
//  Created by hoon on 2023/08/29.
//

import UIKit
import WebKit


class WebViewController: UIViewController, WKUIDelegate {
    
    var webView = WKWebView()
    
//    override func loadView() {
//        let webConfiguration = WKWebViewConfiguration()
//        webView = WKWebView(frame: .zero, configuration: webConfiguration)
//        webView.uiDelegate = self
//        view = webView
//    }


    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(webView)
        
        webView.snp.makeConstraints { make in
            make.edges.equalTo(view).inset(100)
        }
        
        let myURL = URL(string:"https://www.naver.com")
        let myRequest = URLRequest(url: myURL!)
        webView.load(myRequest)
        
        //네비게이션 컨트롤러가 처음에 투명, 스크롤 하면 불투명
        let appearance = UINavigationBarAppearance()
        appearance.backgroundColor = .red
        navigationController?.navigationBar.isTranslucent = false //rootView의 범주가 달라진다.
        navigationController?.navigationBar.scrollEdgeAppearance = appearance
        navigationController?.navigationBar.standardAppearance = appearance
        title = "이건 웹뷰입니다."
    }
    
    func reloadButtonClicked() {
        webView.reload()
    }
    
    func goBackButtonClicked() {
        if webView.canGoBack {
            webView.goBack()
        }
    }
    
    func goForwardButtonClicked() {
        if webView.canGoForward {
            webView.goForward()
        }
    }
}
