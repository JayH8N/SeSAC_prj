//
//  SearchView.swift
//  Pantry
//
//  Created by hoon on 2023/09/27.
//

import UIKit
import SnapKit
import Then
import RealmSwift

class SearchView: BaseView {
    
    var itemList: Results<Items>!
    
    let searchBar = UISearchBar().then {
        $0.barTintColor = UIColor.natural
        $0.tintColor = .black
    }
    
    lazy var searchCollectionView = UICollectionView(frame: .zero, collectionViewLayout: searchCollectionViewLayout()).then {
        $0.backgroundColor = .clear
        $0.register(SearchItemCell.self, forCellWithReuseIdentifier: SearchItemCell.identifier)
        $0.delegate = self
        $0.dataSource = self
    }
    
    func searchCollectionViewLayout() -> UICollectionViewLayout {
        let layout = UICollectionViewFlowLayout()
        layout.minimumInteritemSpacing = 7
        layout.minimumLineSpacing = 15
        layout.scrollDirection = .vertical
        let size = UIScreen.main.bounds.width - 36
        layout.itemSize = CGSize(width: size / 3, height: (size / 3) * 1.65)
        layout.sectionInset = UIEdgeInsets(top: 10, left: 11, bottom: 10, right: 11)
        return layout
    }
    
    
    override func configureView() {
        addSubview(searchBar)
        addSubview(searchCollectionView)
    }
    
    override func setConstraints() {
        searchBar.snp.makeConstraints {
            $0.top.trailing.leading.equalTo(self.safeAreaLayoutGuide)
        }

        searchCollectionView.snp.makeConstraints {
            $0.top.equalTo(searchBar.snp.bottom)
            $0.leading.trailing.bottom.equalTo(self.safeAreaLayoutGuide)
        }
    }
    
}

extension SearchView: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return itemList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: SearchItemCell.identifier, for: indexPath) as! SearchItemCell
        
        let data = itemList[indexPath.item]
        
        cell.setCell(data: data)
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let data = itemList[indexPath.item]
        HapticFeedbackManager.shared.provideFeedback()
        
        let vc = EditItemViewController()
        vc.data = data
        let nav = UINavigationController(rootViewController: vc)
        
        self.window?.rootViewController?.present(nav, animated: true)
    }
    
    
}
