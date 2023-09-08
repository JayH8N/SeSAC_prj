//
//  SearchView.swift
//  Recap_2
//
//  Created by hoon on 2023/09/08.
//

import UIKit


struct A {
    let title: String
    let name: String
    let price: String
}

class SearchView: BaseView {
    
    var filterList = ["정확도", "날짜순", "가격높은순", "가격낮은순"]
    
    var textList: [A] = [
    A(title: "content", name: "제목1", price: "100000000"),
    A(title: "dkdkda;lsdkjf;alsdjkfl;wkjl;fjw;ljfkwl;jflw;jkdf;lwkjdf;lwkj", name: "제목2", price: "4000"),
    A(title: "contentcontentcontent", name: "제목3", price: "2300000"),
    A(title: "content", name: "제목4", price: "10"),
    A(title: "content", name: "제목5", price: "123000"),
    A(title: "contentcontentcontentcontentcontentcontentcontentcontentcontent", name: "제목6", price: "6000")
    ]
    
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



extension SearchView: UICollectionViewDataSource, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return collectionView == filter ? filterList.count : textList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if collectionView == filter {
            guard let cell1 = collectionView.dequeueReusableCell(withReuseIdentifier: FilterCell.identifier, for: indexPath) as? FilterCell else { return UICollectionViewCell() }
            cell1.filterLabel.text = filterList[indexPath.row]
            return cell1
        } else {
            guard let cell2 = collectionView.dequeueReusableCell(withReuseIdentifier: ResultsCell.identifier, for: indexPath) as? ResultsCell else { return UICollectionViewCell() }
            cell2.itemImage.backgroundColor = .yellow
            cell2.mallNameLabel.text = textList[indexPath.row].name
            cell2.titleLabel.text = textList[indexPath.row].title
            cell2.priceLabel.text = textList[indexPath.row].price
            return cell2
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
