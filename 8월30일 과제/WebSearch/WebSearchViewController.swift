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
        return imageURL.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: WebSearchCollectionViewCell.identifier, for: indexPath) as? WebSearchCollectionViewCell else { return UICollectionViewCell() }
        
        
        if let url = URL(string: imageURL[indexPath.row]) {
            cell.imageView.kf.setImage(with: url)
        }
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        NotificationCenter.default.post(name: Notification.Name("SelectedImage"), object: nil, userInfo: ["url": imageURL[indexPath.item]])
        
        
        dismiss(animated: true)
        imageURL.removeAll()
    }

    
}

extension WebSearchViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {

        callRequest(type: .search, text: mainView.searchBar.text ?? "")

        mainView.searchBar.resignFirstResponder()
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        imageURL.removeAll()
        mainView.searchBar.text = ""
        mainView.collectionView.reloadData()
        print(imageURL)
    }
    
}


extension WebSearchViewController {
    func callRequest(type: Endpoint, text: String) {
        let keyword = text.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!
        let url = type.callRequest + keyword + "&client_id=\(APIKey.unsplashKey)"
        
        AF.request(url, method: .get).validate().responseJSON { response in
            switch response.result {
            case .success(let value):
                let json = JSON(value)
                
                for i in json["results"].arrayValue {
                    let url = i["urls"]["regular"].stringValue
                    
                    self.imageURL.append(url)
                }
                self.mainView.collectionView.reloadData()
                
            case .failure(let error):
                print(error)
            }
        }
    }

}
