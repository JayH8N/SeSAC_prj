//
//  SearchView.swift
//  Recap_2
//
//  Created by hoon on 2023/09/08.
//

import UIKit

class SearchView: BaseView {
    
    var filterList = ["정확도", "날짜순", "가격높은순", "가격낮은순"]
    
    let searchBar = SearchBarCustom()
    
    lazy var filter = {
        let view = UICollectionView(frame: .zero, collectionViewLayout: collectionViewLayout())
        view.register(FilterCell.self, forCellWithReuseIdentifier: FilterCell.identifier)
        view.backgroundColor = .clear
        view.dataSource = self
        view.delegate = self
        return view
    }()
    
    func collectionViewLayout() -> UICollectionViewLayout {
        let layout = UICollectionViewFlowLayout()
        layout.minimumInteritemSpacing = 5
        layout.scrollDirection = .horizontal
        layout.sectionInset = UIEdgeInsets(top: 0, left: 9, bottom: 0, right: 9)
        return layout
    }
    
    
    
    override func configureView() {
        searchBar.showsCancelButton = true
        [searchBar, filter].forEach {
            addSubview($0)
        }
    }
    
    override func setConstraints() {
        searchBar.snp.makeConstraints { make in
            make.top.horizontalEdges.equalTo(self.safeAreaLayoutGuide)
        }
        
        filter.snp.makeConstraints { make in
            make.top.equalTo(searchBar.snp.bottom)
            make.leading.trailing.equalToSuperview()
            make.height.equalTo(self.snp.height).multipliedBy(0.05)
        }
    }
    
    
    
    
}







extension SearchView: UICollectionViewDataSource, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return filterList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: FilterCell.identifier, for: indexPath) as? FilterCell else { return UICollectionViewCell() }
        
        cell.filterLabel.text = filterList[indexPath.row]
        
        return cell
    }
    
    
    
}

//Cell 사이즈
extension SearchView: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let label = {
            let view = UILabel()
            view.font = .systemFont(ofSize: 14)
            view.text = filterList[indexPath.row]
            view.sizeToFit()
            return view
        }()
        
        let size = label.frame.size
            
        return CGSize(width: size.width + 10, height: size.height + 12)
    }
}
