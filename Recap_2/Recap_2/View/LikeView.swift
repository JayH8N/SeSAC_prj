//
//  LikeView.swift
//  Recap_2
//
//  Created by hoon on 2023/09/09.
//

import UIKit

final class LikeView: BaseView {
    
    let searchBar = SearchBarCustom()
    let repository = NaverShoppingRepository()
    
    lazy var stored = repository.fetch()
    
    weak var delegate: FunctionDeliveryProtocol?
    
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
        
        [searchBar, resultsLike].forEach {
            addSubview($0)
        }
    }
    
    
    override func setConstraints() {
        searchBar.snp.makeConstraints {
            $0.top.horizontalEdges.equalTo(self.safeAreaLayoutGuide)
        }
        
        resultsLike.snp.makeConstraints {
            $0.top.equalTo(searchBar.snp.bottom)
            $0.leading.trailing.equalToSuperview()
            $0.bottom.equalTo(self.safeAreaLayoutGuide)
        }
    }
}

extension LikeView: UICollectionViewDataSource, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return stored.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        guard let likedCell = collectionView.dequeueReusableCell(withReuseIdentifier: ResultsCell.identifier, for: indexPath) as? ResultsCell else { return UICollectionViewCell() }
        
        let data = stored[indexPath.item]
        
        likedCell.likeCell(data: data)
        likedCell.likeButton.setButtonImage(size: 30, systemName: "xmark")
        likedCell.likeButton.tag = indexPath.item
        likedCell.likeButton.addTarget(self, action: #selector(likeButtonTapped), for: .touchUpInside)
        
        return likedCell
    }
    
    @objc func likeButtonTapped(_ sender: UIButton) {
        let data = stored[sender.tag]
        
        DocumentManager.shared.removeImageFromDocument(fileName: "JH\(data.productId)")
        repository.removeItem(data)
        
        resultsLike.reloadData()
    }
    
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let vc = DetailViewController()
//        vc.mainView.title = removeTag(stored[indexPath.item].title)
//        vc.mainView.productID = stored[indexPath.item].productId
        let data = stored[indexPath.item]
        
        vc.mainView.deliveryValue = Items(productId: data.productId, image: data.image, mallName: data.mallName, title: data.title, lprice: data.lprice)
        
        
        delegate?.didselectItemAt?(vc: vc)
    }
    
    
}

extension LikeView: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
    }
    
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBar.text = ""
        searchBar.resignFirstResponder()
        resultsLike.reloadData()
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        
        guard let text = searchBar.text else { return }
        
        stored = repository.searchTitle(text: text)
        
        resultsLike.reloadData()
        
        if text == "" {
            stored = repository.fetch()
            
            resultsLike.reloadData()
        }
    }
    
    
}


extension LikeView: UIScrollViewDelegate {
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        searchBar.resignFirstResponder()
    }
}
