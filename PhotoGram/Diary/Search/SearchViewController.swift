//
//  SearchViewController.swift
//  Diary
//
//  Created by hoon on 2023/08/28.
//

import UIKit

class SearchViewController: BaseViewController {

    let mainView = SearchView()
    
    let imageList = ["pencil", "star", "person", "star.fill", "xmark", "person.circle"]
    
    override func loadView() {
        self.view = mainView
    }
    //💡💡2.값전달
    var delegate: PassImageDataDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //⚠️addObserver보다 post가 먼저 신호를 보내면 addObserver가 신호를 받지 못한다.!!(정방향)
        NotificationCenter.default.addObserver(self, selector: #selector(recommandKeywordNotificationObserver), name: NSNotification.Name("RecommandKeyword"), object: nil)
        
        mainView.searchBar.becomeFirstResponder() //유저가 터치하지 않아도 서치바의 커서가 바로 깜빡이고 키보드가 바로 뜨게 된다.
        mainView.searchBar.delegate = self
    }
    
    @objc func recommandKeywordNotificationObserver(notification: NSNotification) {
        print("recommandKeywordNotificationObserver") //정방향 값전달?? 왜 안되?
    }
    
    
    override func configureView() {
        super.configureView()
        mainView.collectionView.delegate = self
        mainView.collectionView.dataSource = self
    }

}

extension SearchViewController: UISearchBarDelegate {
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        mainView.searchBar.resignFirstResponder() //유저의 포커스가 서치바에 없다는 것을 명시적으로 알려줌(키보드가 내려가게 됨)
    }
    
}

extension SearchViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return imageList.count
    }
    

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "SearchCollectionViewCell", for: indexPath) as? SearchCollectionViewCell else { return UICollectionViewCell() }
        
        cell.imageView.image = UIImage(systemName: imageList[indexPath.item])
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        //protocol값전달
        //💡💡3.값전달
        delegate?.receiveImage(image: UIImage(systemName: imageList[indexPath.item])!)
        
        
        //print(imageList[indexPath.item])
        
        //1️⃣값전달. Notification
//        NotificationCenter.default.post(name: NSNotification.Name("SelectImage"), object: nil, userInfo: ["name": imageList[indexPath.item], "sample": "고래밥"])
        
        dismiss(animated: true)
        
    }
    
    
}
