//
//  SearchView.swift
//  Recap_2
//
//  Created by hoon on 2023/09/08.
//

import UIKit

class SearchView: BaseView {
    
    let searchBar = SearchBarCustom()
    
    
    
    
    
    override func configureView() {
        searchBar.showsCancelButton = true
        [searchBar].forEach {
            addSubview($0)
        }
    }
    
    override func setConstraints() {
        searchBar.snp.makeConstraints { make in
            make.top.horizontalEdges.equalTo(self.safeAreaLayoutGuide)
        }
    }
    
    
    
    
}
