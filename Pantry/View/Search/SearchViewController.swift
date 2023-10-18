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
        mainView.searchBar.delegate = self
        
        self.hideKeyboardWhenTappedAround()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        mainView.searchBar.becomeFirstResponder()
    }
    
    override func setNavigationBar() {
        
    }
    
    
}

extension SearchViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        mainView.searchBar.resignFirstResponder()
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        mainView.searchBar.text = ""
        mainView.searchBar.resignFirstResponder()
    }
}
