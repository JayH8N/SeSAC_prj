//
//  SearchView.swift
//  Recap_2
//
//  Created by hoon on 2023/09/08.
//

import UIKit




class SearchView: BaseView {
    
    var filterList = ["정확도", "날짜순", "가격낮은순", "가격높은순"]
    var shoppingList: Shopping = Shopping(total: 0, start: 1, display: 0, items: [])
    var page: Int = 1
    
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
        searchBar.becomeFirstResponder()
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
    
}

//MARK: - Extension

extension SearchView: UICollectionViewDataSource, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return collectionView == filter ? filterList.count : shoppingList.items.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if collectionView == filter {
            guard let filterCell = collectionView.dequeueReusableCell(withReuseIdentifier: FilterCell.identifier, for: indexPath) as? FilterCell else { return UICollectionViewCell() }
            filterCell.filterLabel.text = filterList[indexPath.row]
            return filterCell
        } else {
            //collectionView == results
            guard let resultCell = collectionView.dequeueReusableCell(withReuseIdentifier: ResultsCell.identifier, for: indexPath) as? ResultsCell else { return UICollectionViewCell() }
            let data = shoppingList.items[indexPath.item]
            resultCell.setCell(data: data)
            return resultCell
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
        shoppingList = Shopping(total: 0, start: 1, display: 0, items: [])
        page = 1
        
        guard let text = searchBar.text else { return }
        
        NaverAPIManager.shared.callRequest(keyword: text, sort: .sim, page: page) { [weak self] data in
            self?.shoppingList = data
            
            self?.results.reloadData()
        }
        
        if shoppingList.items.isEmpty {
            delegate?.showAlert?(title: "검색결과가 존재하지 않습니다.")
        }
    }
    
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBar.text = ""
        shoppingList = Shopping(total: 0, start: 1, display: 0, items: [])
        results.reloadData()
    }
}
