//
//  SearchView.swift
//  Pantry
//
//  Created by hoon on 2023/09/27.
//

import UIKit
import SnapKit
import Then

class SearchView: BaseView {
    
    let blurEffect = UIVisualEffectView(effect: UIBlurEffect(style: .light))
    
    let searchBar = UISearchBar().then {
        $0.searchTextField.layer.borderColor = UIColor.black.cgColor
        $0.searchTextField.layer.borderWidth = 3
        $0.searchTextField.layer.cornerRadius = 10
        $0.barTintColor = UIColor.natural2
        $0.tintColor = .black
    }
    
    
    override func configureView() {
        super.configureView()
        addSubview(blurEffect)
        addSubview(searchBar)
    }
    
    override func setConstraints() {
        blurEffect.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
        searchBar.snp.makeConstraints {
            $0.top.trailing.leading.equalTo(self.safeAreaLayoutGuide)
        }
    }
    
}

extension SearchView: UISearchBarDelegate {
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        
    }
    
}
