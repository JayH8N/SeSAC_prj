//
//  SearchVC.swift
//  App_Store
//
//  Created by hoon on 11/6/23.
//

import UIKit
import RxSwift
import RxCocoa
import Kingfisher

class SearchVC: BaseVC {
    
    let disposeBag = DisposeBag()
    
    let mainView = SearchView()
    
    var data: [AppInfo] = []
    lazy var appList = BehaviorSubject(value: data)
    
    override func loadView() {
        view = mainView
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableViewBind()
    }
    
    private func tableViewBind() {
        appList
            .bind(to: mainView.tableView.rx.items(cellIdentifier: SearchViewTableViewCell.identifier, cellType: SearchViewTableViewCell.self)) { (row, element, cell) in
                cell.appNameLabel.text = element.trackName
                
                let url = element.artworkUrl512
                
                if let url = URL(string: url) {
                    cell.appIconImage.kf.setImage(with: url, options: [.processor(ResizingImageProcessor(referenceSize: CGSize(width: 60, height: 60)))])
                }
            }
            .disposed(by: disposeBag)
        
        mainView.searchBar.rx.text.orEmpty
            .debounce(RxTimeInterval.seconds(1), scheduler: MainScheduler.instance)
            .distinctUntilChanged()
            .subscribe(with: self) { owner, value in
                let request = BasicAPIManager.shared.fetchData(keyword: value).asDriver(onErrorJustReturn: SearchAppModel(resultCount: 0, results: []))
                
                request
                    .drive(with: self) { owner, result in
                        owner.appList.onNext(result.results)
                    }
                    .disposed(by: owner.disposeBag)
            }
            .disposed(by: disposeBag)
        
    }
    
    private func setSearchController() {
        self.navigationItem.titleView = mainView.searchBar
        
        
    }
    
    
    override func configureView() {
        setSearchController()
    }
    
    override func setConstraints() {
        
    }
    
}
