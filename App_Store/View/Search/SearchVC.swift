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
    
    let viewModel = SearchViewModel()
    
    let mainView = SearchView()
    
    override func loadView() {
        view = mainView
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableViewBind()
        
    }
    
    private func tableViewBind() {
        viewModel.appLists
            .bind(to: mainView.tableView.rx.items(cellIdentifier: SearchViewTableViewCell.identifier, cellType: SearchViewTableViewCell.self)) {(row, element, cell) in
                cell.appNameLabel.text = element.trackName
                
                let url = element.artworkUrl60
                if let url = URL(string: url) {
                    cell.appIconImage.kf.setImage(with: url)
                    //, options: [.processor(ResizingImageProcessor(referenceSize: CGSize(width: 60, height: 60)))])
                }
            }
            .disposed(by: viewModel.disposeBag)
        
        
        //PublishRelay Case
//        mainView.searchBar
//                    .rx
//                    .searchButtonClicked
//                    .throttle(.seconds(1), scheduler: MainScheduler.instance)
//                    .withLatestFrom(mainView.searchBar.rx.text.orEmpty)
//                    .bind(with: self) { owner, text in
//                        BasicAPIManager.shared.fetchData(keyword: text)
//                            .asDriver(onErrorJustReturn: SearchAppModel(resultCount: 0, results: []))
//                            .drive(with: self) { owner, value in
//                                owner.viewModel.appLists.accept(value.results)
//                            }
//                            .disposed(by: owner.viewModel.disposeBag)
//                    }
//                    .disposed(by: viewModel.disposeBag)
        
        
        mainView.searchBar
            .rx
            .searchButtonClicked
            .throttle(.seconds(1), scheduler: MainScheduler.instance)
            .withLatestFrom(mainView.searchBar.rx.text.orEmpty) { _, query in
                return query
            }
            .flatMap { BasicAPIManager.shared.fetchData(keyword: $0) }
            .subscribe(with: self) { owner, appData in
                let data = appData.results
                owner.viewModel.appLists.onNext(data)
            }
            .disposed(by: viewModel.disposeBag)
        
        
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
