//
//  SearchViewController.swift
//  Recap_2
//
//  Created by hoon on 2023/09/07.
//

import UIKit


final class SearchViewController: BaseViewController {
    
    let repository = NaverShoppingRepository()
    
    let mainView = SearchView()
    
    override func loadView() {
        view = mainView
        mainView.delegate = self
    }
    
    convenience init(title: String) {
        self.init()
        self.title = title
        
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
       
        
        repository.realmPathCheck()
        mainView.stored = repository.fetch()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        mainView.results.reloadData()
    }

    
}

extension SearchViewController: FunctionDeliveryProtocol {
    
    func showAlert(title: String) {
        let alert = UIAlertController(title: title, message: nil, preferredStyle: .alert)
        let ok = UIAlertAction(title: "확인", style: .default)
        alert.addAction(ok)
        present(alert, animated: true, completion: nil)
    }
    
    func didselectItemAt(vc: UIViewController) {
        navigationController?.pushViewController(vc, animated: true)
    }
}
