//
//  SearchViewController.swift
//  Recap_2
//
//  Created by hoon on 2023/09/07.
//

import UIKit


@objc protocol SearchViewProtocol: AnyObject {
    @objc optional func didselectItemAt(indexPath: IndexPath)
    @objc optional func showAlert(title: String)
}

class SearchViewController: BaseViewController {
    
    override func loadView() {
        view = SearchView()
        SearchView().delegate = self
    }
    
    convenience init(title: String) {
        self.init()
        self.title = title
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
    }
    
    override func setNavigationBar() {
        navigationController?.navigationBar.titleTextAttributes = [.foregroundColor: UIColor.white]
    }
    
    override func configureView() {
        
    }
    
    override func setConstraints() {
        
    }
    
    
}

extension SearchViewController: SearchViewProtocol {
    func showAlert(title: String) {
        let alert = UIAlertController(title: title, message: nil, preferredStyle: .alert)
        let ok = UIAlertAction(title: "확인", style: .default)
        alert.addAction(ok)
        present(alert, animated: true, completion: nil)
    }
}
