//
//  SearchView.swift
//  Recap_2
//
//  Created by hoon on 2023/09/08.
//

import UIKit

@objc protocol SearchViewProtocol: AnyObject {
    @objc optional func didselectItemAt(vc: UIViewController)
    @objc optional func showAlert(title: String)
}


class SearchView: BaseView {
    
    var filterList = ["정확도", "날짜순", "가격낮은순", "가격높은순"]
    var shoppingList: Shopping = Shopping(total: 0, items: [])
    
    var page: Int = 1
    //var maxPage: Int = 0
    var text: String?
     
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
    
//    func calculateMaxPage(total: Int) {
//        if total >= 30000 {
//            maxPage = 1000
//        } else {
//            maxPage = (total / 30) + 1
//        }
//    }
    
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
                filter.selectItem(at: indexPath, animated: false, scrollPosition: .init()) //???: - ⚠️셀이 재사용되는 순간 의도와 다르게 다시 선택 될 수있음....
            }
            
            return filterCell
        } else {
            //collectionView == results
            guard let resultCell = collectionView.dequeueReusableCell(withReuseIdentifier: ResultsCell.identifier, for: indexPath) as? ResultsCell else { return UICollectionViewCell() }
            let data = shoppingList.items[indexPath.item]
            resultCell.setCell(data: data)
            
            return resultCell
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
            vc.mainView.title = shoppingList.items[indexPath.item].title.replacingOccurrences(of: "</b>", with: "").replacingOccurrences(of: "<b>", with: "")
                    
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
        
        guard let text = searchBar.text else { return }
        self.text = text
        
        NaverAPIManager.shared.callRequest(keyword: text, sort: .sim, page: page) { data in
            self.shoppingList = data
            self.results.reloadData()
        }
        
    }
    
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBar.text = ""
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
    
    
//    func scrollViewDidScroll(_ scrollView: UIScrollView) {
//        //print(#function)
//
//        let offsetY = results.contentOffset.y
//        let contentHeight = results.contentSize.height
//        let paginationOrigin = contentHeight * 0.7
//
//        if offsetY > paginationOrigin && page < maxPage {
//            page += 1
//            NaverAPIManager.shared.callRequest(keyword: searchBar.text!, sort: .sim, page: page) { data in
//                self.shoppingList = data
//                self.results.reloadData()
//            }
//        }
//
//    }
    
}
