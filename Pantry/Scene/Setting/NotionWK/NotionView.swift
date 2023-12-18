//
//  NotionView.swift
//  Pantry
//
//  Created by hoon on 12/18/23.
//

import UIKit
import SnapKit
import Then
import WebKit

final class NotionView: BaseView, WKUIDelegate {
    
    private let webConfig = WKWebViewConfiguration()
    
    lazy var webView = WKWebView(frame: .zero, configuration: webConfig).then {
        $0.uiDelegate = self
    }
    
    
    override func configureView() {
        addSubview(webView)
    }
    
    override func setConstraints() {
        webView.snp.makeConstraints {
            $0.edges.equalTo(self.safeAreaLayoutGuide)
        }
    }
}
