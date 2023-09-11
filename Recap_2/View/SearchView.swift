//
//  SearchView.swift
//  Recap_2
//
//  Created by hoon on 2023/09/08.
//

import UIKit
import RealmSwift

@objc protocol SearchViewProtocol: AnyObject {
    @objc optional func didselectItemAt(vc: UIViewController)
    @objc optional func showAlert(title: String)
}


class SearchView: BaseView {
    
    var filterList = ["정확도", "날짜순", "가격낮은순", "가격높은순"]
    var shoppingList: Shopping = Shopping(total: 0, items: [])
    var bool: Bool = false
    
    //페이지 네이션관련
    var page: Int = 1
    var maxPage: Int = 0
    var ongoing: Bool = false
    
    
    var text: String?
    var stored: Results<Items>!
    
    let repository = NaverShoppingRepository()
     
    weak var delegate: SearchViewProtocol?
    
    
    let searchBar = SearchBarCustom()
    
    //filterCollectionView
    lazy var filter = {
        let view = UICollectionView(frame: .zero, collectionViewLayout: filterCollectionViewLayout())
        view.register(FilterCell.self, forCellWithReuseIdentifier: FilterCell.identifier)
        view.backgroundColor = .clear
        view.dataSource = self
        view.delegate = self
        return view
    }()
    
    //resultsCollectionView
    lazy var results = {
        let view = UICollectionView(frame: .zero, collectionViewLayout: resultsCollectionViewLayout())
        view.register(ResultsCell.self, forCellWithReuseIdentifier: ResultsCell.identifier)
        view.backgroundColor = .clear
        view.dataSource = self
        view.delegate = self
        return view
    }()
    
    
    override func configureView() {
        searchBar.delegate = self
        searchBar.showsCancelButton = true
        searchBar.becomeFirstResponder()
        [searchBar, filter, results].forEach {
            addSubview($0)
        }
    }
    
    override func setConstraints() {
        searchBar.snp.makeConstraints {
            $0.top.horizontalEdges.equalTo(self.safeAreaLayoutGuide)
        }
        
        filter.snp.makeConstraints {
            $0.top.equalTo(searchBar.snp.bottom)
            $0.leading.trailing.equalToSuperview()
            $0.height.equalTo(self.snp.height).multipliedBy(0.05)
        }
        
        results.snp.makeConstraints {
            $0.top.equalTo(filter.snp.bottom)
            $0.leading.trailing.equalToSuperview()
            $0.bottom.equalTo(self.safeAreaLayoutGuide)
        }
    }
    
    func calculateMaxPage(total: Int) {
        if total >= 30000 {
            maxPage = 1000
        } else {
            maxPage = (total / 30) + 1
        }
    }
    
}

//MARK: - Extension

extension SearchView: UICollectionViewDataSource, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return collectionView == filter ? filterList.count : shoppingList.items.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if collectionView == filter {
            guard let filterCell = collectionView.dequeueReusableCell(withReuseIdentifier: FilterCell.identifier, for: indexPath) as? FilterCell else { return UICollectionViewCell() }
            filterCell.filterLabel.text = filterList[indexPath.item]
            
            if indexPath.item == 0 {
                filterCell.isSelected = true
                filter.selectItem(at: indexPath, animated: false, scrollPosition: .init()) //???: - 셀이 재사용되는 순간 의도와 다르게 다시 선택 될 수있음....
            }
            
            return filterCell
            
        } else {
            //collectionView == results
            guard let resultCell = collectionView.dequeueReusableCell(withReuseIdentifier: ResultsCell.identifier, for: indexPath) as? ResultsCell else { return UICollectionViewCell() }
            let data = shoppingList.items[indexPath.item]
            resultCell.setCell(data: data)
            resultCell.setButtonImage(button: resultCell.likeButton, size: 30, systemName: "heart")
            resultCell.likeButton.tag = indexPath.item
            resultCell.likeButton.addTarget(self, action: #selector(likeButtonTapped), for: .touchUpInside)
            
            return resultCell
        }
    }
    
    @objc func likeButtonTapped(_ sender: UIButton) {
        let data = shoppingList.items[sender.tag]
        
        //true
        let task = Items(productId: data.productId, image: data.image, mallName: data.mallName, title: data.title, lprice: data.lprice)
        
        repository.createItem(task)
        //stored = repository.fetch()
        
        DispatchQueue.global().async {
            if let url = URL(string: data.image), let data = try? Data(contentsOf: url) {
                DispatchQueue.main.async {
                    DocumentManager.shared.saveImageToDocument(fileName: "JH\(task._id)", image: UIImage(data: data)!)
                }
            }
        }
    }
    
    
    
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if collectionView == filter {
            guard let text = text else {
                delegate?.showAlert?(title: "검색어를 기입해주세요")
                return
            }
            switch indexPath.item {
            case 0:
                NaverAPIManager.shared.callRequest(keyword: text, sort: .sim, page: page) { data in
                    self.shoppingList = data
                    self.results.reloadData()
                }
            case 1:
                NaverAPIManager.shared.callRequest(keyword: text, sort: .date, page: page) { data in
                    self.shoppingList = data
                    self.results.reloadData()
                }
            case 2:
                NaverAPIManager.shared.callRequest(keyword: text, sort: .asc, page: page) { data in
                    self.shoppingList = data
                    self.results.reloadData()
                }
            case 3:
                NaverAPIManager.shared.callRequest(keyword: text, sort: .dsc, page: page) { data in
                    self.shoppingList = data
                    self.results.reloadData()
                }
            default: break
            }
        } else {
            let vc = DetailViewController()
            vc.mainView.productID = shoppingList.items[indexPath.item].productId
            vc.mainView.title = removeTag(shoppingList.items[indexPath.item].title)
                    
            delegate?.didselectItemAt?(vc: vc)
        }
    }
         
}

//Cell 사이즈
extension SearchView: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {

        if collectionView == filter {
            let label = {
                let view = UILabel()
                view.font = .systemFont(ofSize: 14)
                view.text = filterList[indexPath.row]
                view.sizeToFit()
                return view
            }()

            let size = label.frame.size
            
            return CGSize(width: size.width + 10, height: size.height + 12)
        } else {
            
            let size = UIScreen.main.bounds.width - 44
            
            return CGSize(width: size / 2, height: (size / 2) * 1.43)
        }
    }
}


//서치바
extension SearchView: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        
        searchBar.resignFirstResponder()
        shoppingList = Shopping(total: 0, items: [])
        page = 1
        ongoing = false
        
        guard let text = searchBar.text else { return }
        self.text = text
        
        NaverAPIManager.shared.callRequest(keyword: text, sort: .sim, page: page) { data in
            self.shoppingList = data
            self.calculateMaxPage(total: data.total)
            self.results.reloadData()
        }
        
    }
    
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBar.text = ""
        searchBar.resignFirstResponder()
        page = 1
        text = nil
        shoppingList = Shopping(total: 0, items: [])
        results.reloadData()
    }
}


extension SearchView: UIScrollViewDelegate {
    //스크롤시 키보드 내리기
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        searchBar.resignFirstResponder()
    }
    
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        //print(#function)
        print(page, maxPage, ongoing)
        let offsetY = results.contentOffset.y
        let contentHeight = results.contentSize.height
        let paginationOrigin = contentHeight * 0.7
        
        
        
        if offsetY > paginationOrigin && page < maxPage && !ongoing {
            ongoing = true
            page += 1
            
            
            guard let text = self.searchBar.text else { return }
            DispatchQueue.global().async {
                NaverAPIManager.shared.callRequest(keyword: text, sort: .sim, page: self.page) { [weak self] data in
                    
                    self?.shoppingList.items.append(contentsOf: data.items)
                    DispatchQueue.main.async {
                        
                        self?.ongoing = false
                        self?.results.reloadData()
                        
                    }
                }
            }
        }
    }
}
