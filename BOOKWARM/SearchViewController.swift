//
//  SearchViewController.swift
//  BOOKWARM
//
//  Created by hoon on 2023/07/31.
//

import UIKit

class SearchViewController: UIViewController {
    
    static let identifier = "SearchViewController"
    
    var searchContents: String = "검색화면"
    @IBOutlet var contentsLabel: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = searchContents
        
        view.backgroundColor = .orange
        contentsLabel.text = searchContents
        contentsLabel.textAlignment = .center
        contentsLabel.font = UIFont.systemFont(ofSize: 30)
        
        let xmark = UIImage(systemName: "xmark")
        navigationItem.leftBarButtonItem = UIBarButtonItem.init(image: xmark, style: .plain, target: self, action: #selector(closeButtonClicked))
        navigationItem.leftBarButtonItem?.tintColor = .black
    }
    
    @objc
    func closeButtonClicked(_ sender: UIBarButtonItem) {
        dismiss(animated: true)
    }

}
