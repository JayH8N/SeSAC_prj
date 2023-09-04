//
//  SearchViewController.swift
//  BookWorm
//
//  Created by hoon on 2023/09/04.
//

import UIKit
import SnapKit
import Kingfisher
import RealmSwift

class SearchViewController: UIViewController {
    
    var list: KakaoBook = KakaoBook(documents: [])
    var page: Int = 1

    let searchBar = {
        let view = UISearchBar()
        view.placeholder = "책 제목을 검색해 주세요"
        return view
    }()
    
    lazy var collectionView = {
        let view = UICollectionView(frame: .zero, collectionViewLayout: collectionViewLayout())
        view.register(SearchCollectionViewCell.self, forCellWithReuseIdentifier: "Search")
        return view
    }()
    
    func collectionViewLayout() -> UICollectionViewLayout {
        let layout = UICollectionViewFlowLayout()
        layout.minimumLineSpacing = 10
        layout.minimumInteritemSpacing = 8
        layout.scrollDirection = .vertical
        layout.sectionInset = UIEdgeInsets(top: 10, left: 10, bottom: 10, right:  10)
        let size = UIScreen.main.bounds.width - 36 //컬렉션뷰 생성 전이라 collectionView.bounds.width사용을 못한다.
        layout.itemSize = CGSize(width: size / 3, height: 160)
        return layout
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        collectionView.delegate = self
        collectionView.dataSource = self
        
        searchBar.delegate = self
        searchBar.showsCancelButton = true
        searchBar.becomeFirstResponder()
        
        configureView()
        setConstraints()
    }
    
    func configureView() {
        
        view.addSubview(searchBar)
        view.addSubview(collectionView)
    }
    
    func setConstraints() {
        searchBar.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide)
            make.leading.trailing.equalToSuperview().inset(10)
        }
        
        collectionView.snp.makeConstraints { make in
            make.top.equalTo(searchBar.snp.bottom).offset(8)
            make.leading.trailing.bottom.equalToSuperview()
        }
        
    }
    

    

}

extension SearchViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return list.documents.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Search", for: indexPath) as! SearchCollectionViewCell
        
        let data = list.documents[indexPath.row]
        
        cell.layer.borderColor = UIColor.black.cgColor
        cell.layer.borderWidth = 2
        cell.author.text = data.authors[0]
        cell.title.text = data.title
        
        let url = data.thumbnail
        
        if let url = URL(string: url) {
            cell.coverPoster.kf.setImage(with: url)
        }

        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let realm = try! Realm()
        
        let data = list.documents[indexPath.row]
        
        let task = BookTable(posterURL: data.thumbnail, bookTitle: data.title, bookAuthor: data.authors[0])
        
        try! realm.write {
            realm.add(task)
            print("Realm Add Succeed")
        }
        
        
        navigationController?.popViewController(animated: true)
    }
    
}


extension SearchViewController: UISearchBarDelegate {
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        print("누름")
        page = 1
        list = KakaoBook(documents: [])
        
        print(searchBar.text!)
        KakaoAPIManager.shared.callRequest(page: page, query: searchBar.text!) { value in
            self.list = value
            
            print("==============\(self.list)")
            
            self.collectionView.reloadData()
        }
        
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        list = KakaoBook(documents: [])
        searchBar.text = ""
        collectionView.reloadData()
    }

}

extension SearchViewController {
    
    func showAlertView(title: String, message: String? = nil, handler: ((UIAlertAction) -> Void)? = nil) {
        
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        
        
        let ok = UIAlertAction(title: "확인", style: .default, handler: handler)
        let cancel = UIAlertAction(title: "No", style: .cancel)
        
        alert.addAction(ok)
        alert.addAction(cancel)
        
        
        present(alert, animated: true, completion: nil)
    }
    
}
