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


//CollectionView
extension TVMainViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return tvList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: TVCollectionViewCell.identifier, for: indexPath) as? TVCollectionViewCell else { return UICollectionViewCell() }
        
        let item = tvList[indexPath.item]
        cell.setCell(item: item)
        
        
        return cell
    }
    
    
}


extension TVMainViewController: CollectionViewAttributeProtocol {
    func configureCollectionView() {
        collectionView.dataSource = self
        collectionView.delegate = self
        
        let nib = UINib(nibName: TVCollectionViewCell.identifier, bundle: nil)
        collectionView.register(nib, forCellWithReuseIdentifier: TVCollectionViewCell.identifier)
    }
    
    func configureCollectionViewLayout() {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        let spacing: CGFloat = 8
        let width = UIScreen.main.bounds.width - (spacing * 4)
        layout.scrollDirection = .vertical
        layout.itemSize = CGSize(width: width / 3, height: 210)
        layout.sectionInset = UIEdgeInsets(top: 16, left: spacing, bottom: 0, right: spacing) // CollectionView의 상하좌우 여백
        layout.minimumLineSpacing = 10
        layout.minimumInteritemSpacing = spacing
        
        collectionView.collectionViewLayout = layout
    }
    
    
}
