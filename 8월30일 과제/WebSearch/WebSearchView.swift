//
//  WebSearchView.swift
//  Diary
//
//  Created by hoon on 2023/08/30.
//

import UIKit

class WebSearchView: BaseView {
    
    let searchBar = {
        let view = UISearchBar()
        view.placeholder = "검색어를 입력해주세요"
        return view
    }()
    
    lazy var collectionView = {
        let view = UICollectionView(frame: .zero, collectionViewLayout: collectionViewLayout())
        view.register(WebSearchCollectionViewCell.self, forCellWithReuseIdentifier: WebSearchCollectionViewCell.identifier)
        return view
    }()
    
    func collectionViewLayout() -> UICollectionViewLayout {
        let layout = UICollectionViewFlowLayout()
        layout.minimumLineSpacing = 10
        layout.minimumInteritemSpacing = 8
        layout.scrollDirection = .vertical
        layout.sectionInset = UIEdgeInsets(top: 10, left: 10, bottom: 10, right:  10)
        let size = UIScreen.main.bounds.width - 40
        layout.itemSize = CGSize(width: size / 3, height: size / 3)
        return layout
    }
    
    
    
    override func configureView() {
        addSubview(searchBar)
        addSubview(collectionView)
    }
    
    
    override func setConstraints() {
        searchBar.snp.makeConstraints { make in
            make.top.horizontalEdges.equalToSuperview()
        }
        collectionView.snp.makeConstraints { make in
            make.top.equalTo(searchBar.snp.bottom).inset(8)
            make.leading.trailing.bottom.equalToSuperview()
        }
    }
    
    
    
}
