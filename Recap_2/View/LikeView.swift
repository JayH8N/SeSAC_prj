//
//  LikeView.swift
//  Recap_2
//
//  Created by hoon on 2023/09/09.
//

import UIKit

class LikeView: BaseView {
    
    let searchBar = SearchBarCustom()
    
    lazy var resultsLike = {
        let view = UICollectionView(frame: .zero, collectionViewLayout: resultsLikeCollectionViewLayout())
        view.register(ResultsCell.self, forCellWithReuseIdentifier: ResultsCell.identifier)
        view.backgroundColor = .clear
        view.dataSource = self
        view.delegate = self
        return view
    }()
    
    
    override func configureView() {
        searchBar.delegate = self
        searchBar.showsCancelButton = true
        
        [searchBar].forEach {
            addSubview($0)
        }
    }
    
    
    override func setConstraints() {
        searchBar.snp.makeConstraints {
            $0.top.horizontalEdges.equalTo(self.safeAreaLayoutGuide)
        }
    }
}

extension LikeView: UICollectionViewDataSource, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        return UICollectionViewCell()
    }
    
    
}

extension LikeView: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
    }
    
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBar.text = ""
        resultsLike.reloadData()
    }
}


extension LikeView: UIScrollViewDelegate {
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        searchBar.resignFirstResponder()
    }
}
