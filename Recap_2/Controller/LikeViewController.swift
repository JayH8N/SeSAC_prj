//
//  LikeViewController.swift
//  Recap_2
//
//  Created by hoon on 2023/09/07.
//

import UIKit


class LikeViewController: BaseViewController {
    
    let mainView = LikeView()
    
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
        
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        mainView.resultsLike.reloadData()
    }
    
    override func setNavigationBar() {
        navigationController?.navigationBar.titleTextAttributes = [.foregroundColor: UIColor.white]
    }
    
    
    override func configureView() {
        
    }
    
    
    override func setConstraints() {
        
    }
}

extension LikeViewController: SearchViewProtocol {
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
