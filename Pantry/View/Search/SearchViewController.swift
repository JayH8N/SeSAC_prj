//
//  SearchViewController.swift
//  Pantry
//
//  Created by hoon on 2023/09/27.
//

import UIKit


class SearchViewController: BaseViewController {
    
    let mainView = SearchView()
    
    override func loadView() {
        view = mainView
    }
    
    convenience init(title: String) {
        self.init()
        self.title = title
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func setNavigationBar() {
        
    }
    
    
}
