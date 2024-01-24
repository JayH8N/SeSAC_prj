//
//  SearchViewController.swift
//  Pantry
//
//  Created by hoon on 2023/09/27.
//

import UIKit
import Then

class SearchViewController: BaseVC {
    
    let repository = RefrigeratorRepository()
    
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
        mainView.itemList = repository.fetchItems()
        mainView.searchBar.delegate = self
        self.hideKeyboardWhenTappedAround()
        
        NotificationCenter.default.addObserver(self, selector: #selector(reloadData), name: Notification.Name("itemReload"), object: nil)
    }
    
    @objc private func reloadData() {
        mainView.searchCollectionView.reloadData()
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
    
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        navigationController?.setNavigationBarHidden(true, animated: true)
        mainView.searchBar.showsCancelButton = true
    }
    
    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
        navigationController?.setNavigationBarHidden(false, animated: true)
        mainView.searchBar.showsCancelButton = false
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        
        guard let text = mainView.searchBar.text else { return }
        mainView.itemList = repository.searchTitle(text: text)
        mainView.searchCollectionView.reloadData()
        
        if text == "" {
            mainView.itemList = repository.fetchItems()
            mainView.searchCollectionView.reloadData()
        }
    }
}

extension SearchViewController: UIScrollViewDelegate {
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        mainView.searchBar.resignFirstResponder()
    }
}
