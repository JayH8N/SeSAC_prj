//
//  Extension + TVMainView.swift
//  Media
//
//  Created by hoon on 2023/08/20.
//

import UIKit

extension TVMainViewController: Reusableidentifier {
    static var identifier: String {
        return String(describing: Self.self)
    }
}


//searchBar
extension TVMainViewController: UISearchBarDelegate {
    func settingButtonTVside() {
        let searchButton = UIImage(systemName: "magnifyingglass")
        navigationItem.rightBarButtonItem = UIBarButtonItem.init(image: searchButton, style: .plain, target: self, action: #selector(searchButtonClickedTVside))
    }
    
    @objc
    func searchButtonClickedTVside(_ sender: UIBarButtonItem) {
        searchBar.isHidden.toggle()
    }
}
