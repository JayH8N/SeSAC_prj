//
//  SearchView.swift
//  App_Store
//
//  Created by hoon on 11/6/23.
//

import UIKit
import RxSwift
import RxCocoa
import SnapKit

class SearchView: BaseView {
    
    let searchBar = UISearchBar()
    
    let tableView = UITableView().then {
        $0.register(SearchViewTableViewCell.self, forCellReuseIdentifier: SearchViewTableViewCell.identifier)
        $0.backgroundColor = .white
        $0.rowHeight = 90
        $0.separatorStyle = .singleLine
    }
    
    
    override func configureView() {
        super.configureView()
        
        self.addSubview(tableView)
        
    }
    
    override func setConstraints() {
        tableView.snp.makeConstraints {
            $0.edges.equalTo(self.safeAreaLayoutGuide)
        }
    }
    
    
}
