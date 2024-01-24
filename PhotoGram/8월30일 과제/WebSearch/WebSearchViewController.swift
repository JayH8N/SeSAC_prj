//
//  WebSearchViewController.swift
//  Diary
//
//  Created by hoon on 2023/08/30.
//

import UIKit
import Alamofire
import SwiftyJSON

struct Splash {
    let url: String
}

class WebSearchViewController: BaseViewController {
    
    let mainView = WebSearchView()
    
    var imageURL: [String] = []
    
    var list: Photo = Photo(total: 0, total_pages: 0, results: [])
    
    override func loadView() {
        self.view = mainView
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        mainView.collectionView.dataSource = self
        mainView.collectionView.delegate = self
        mainView.searchBar.delegate = self
        mainView.searchBar.showsCancelButton = true
        mainView.searchBar.becomeFirstResponder()
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
        return list.results.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: WebSearchCollectionViewCell.identifier, for: indexPath) as? WebSearchCollectionViewCell else { return UICollectionViewCell() }
        
        
        if let url = URL(string: list.results[indexPath.row].urls.thumb) {
            cell.imageView.kf.setImage(with: url)
        }
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        NotificationCenter.default.post(name: Notification.Name("SelectedImage"), object: nil, userInfo: ["url": list.results[indexPath.row].urls.thumb])
        
        
        dismiss(animated: true)
        list = Photo(total: 0, total_pages: 0, results: [])
    }

    
}

extension WebSearchViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {

        //callRequest(type: .search, text: mainView.searchBar.text ?? "")
        APIServie.shared.callRequest(type: .search, keyword: mainView.searchBar.text ?? "") { data in
            guard let data = data else {
                self.showAlertView(title: "통신 실패")
                return
            }
            
            self.list = data
            
            self.mainView.collectionView.reloadData()
        }
    

        mainView.searchBar.resignFirstResponder()
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        list = Photo(total: 0, total_pages: 0, results: [])
        mainView.searchBar.text = ""
        mainView.collectionView.reloadData()
        print(imageURL)
    }
    
}

extension WebSearchViewController {
    
    func showAlertView(title: String, message: String? = nil, handler: ((UIAlertAction) -> Void)? = nil) {
        
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        
        
        let ok = UIAlertAction(title: "확인", style: .default, handler: handler)
        let cancel = UIAlertAction(title: "No", style: .cancel)
        
        alert.addAction(ok)
        alert.addAction(cancel)
        
        
        present(alert, animated: true, completion: nil)
    }
    
}


//extension WebSearchViewController {
//    func callRequest(type: Endpoint, text: String) {
//        let keyword = text.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!
//        let url = type.callRequest + keyword + "&client_id=\(APIKey.unsplashKey)"
//
//        AF.request(url, method: .get).validate().responseJSON { response in
//            switch response.result {
//            case .success(let value):
//                let json = JSON(value)
//
//                for i in json["results"].arrayValue {
//                    let url = i["urls"]["regular"].stringValue
//
//                    self.imageURL.append(url)
//                }
//                self.mainView.collectionView.reloadData()
//
//            case .failure(let error):
//                print(error)
//            }
//        }
//    }
//
//}
