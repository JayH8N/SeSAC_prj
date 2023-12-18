//
//  NotionVC.swift
//  Pantry
//
//  Created by hoon on 12/18/23.
//

import UIKit
import SnapKit
import Then

final class NotionVC: BaseVC {
    
    private let mainView = NotionView()
    
    override func loadView() {
        self.view = mainView
    }
    
    convenience init(link: String) {
        self.init()
        self.loadWebView(link: link)
    }
    
    private func loadWebView(link: String) {
        let myURL = URL(string: link)
        let myRequest = URLRequest(url: myURL!)
        mainView.webView.load(myRequest)
    }
    
}
