//
//  WebSearchViewController.swift
//  Diary
//
//  Created by hoon on 2023/08/30.
//

import UIKit

class WebSearchViewController: BaseViewController {
    
    let mainView = WebSearchView()
    
    override func loadView() {
        self.view = mainView
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        mainView.collectionView.dataSource = self
        mainView.collectionView.delegate = self
    }
    
    
    
    
    override func configureView() {
        super.configureView()
    }
    
    
    
    override func setConstraints() {
        super.setConstraints()
    }
    
    
}

extension WebSearchViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 100
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: WebSearchCollectionViewCell.identifier, for: indexPath) as? WebSearchCollectionViewCell else { return UICollectionViewCell() }
        
        cell.imageView.backgroundColor = .brown
        
        return cell
    }
    
    
    
    
}
