//
//  RefigerPageViewController.swift
//  Pantry
//
//  Created by hoon on 2023/10/09.
//

import UIKit
import RealmSwift

class RefrigerPageViewController: BaseViewController {
    
    var rfID: ObjectId?
    var selectedSort: Sort = .Added
    let mainView = RefigerPageView()
    let repository = RefrigeratorRepository()
    
    override func loadView() {
        view = mainView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        mainView.itemList = repository.fetchItemsInRefrigerator(rfID!, state: .refrigeration, sort: selectedSort)
        
        NotificationCenter.default.addObserver(self, selector: #selector(reloadData), name: Notification.Name("itemReload"), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(added), name: Notification.Name("Ref_Added"), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(ExpFastest), name: Notification.Name("Ref_ExpFastest"), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(ExpSlowest), name: Notification.Name("Ref_ExpSlowest"), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(ExpiredGoods), name: Notification.Name("Ref_ExpiredGoods"), object: nil)
    }
    
    
    override func configureView() {
        mainView.filterButton.addTarget(self,
                                        action: #selector(filterButtonTapped),
                                        for: .touchUpInside)
    }
    
    override func setConstraints() {
        
    }
    
    @objc private func reloadData() {
        mainView.allCollectionView.reloadData()
    }
    
    @objc private func filterButtonTapped() {
        let bulletinBoardVC = FilterButtonVC.instance()
        bulletinBoardVC.delegate = self
        bulletinBoardVC.pageOption = .Refrigerator
        addDim()
        present(bulletinBoardVC, animated: true)
    }
    
    private func addDim() {
        view.addSubview(mainView.bgView)
        mainView.bgView.snp.makeConstraints { make in
            make.edges.equalTo(0)
        }
        
        DispatchQueue.main.async { [weak self] in
            self?.mainView.bgView.alpha = 0.5
        }
    }
    
    private func removeDim() {
        DispatchQueue.main.async { [weak self] in
            self?.mainView.bgView.removeFromSuperview()
        }
    }
    
    
    
}

extension RefrigerPageViewController: BulletinDelegate {
    func onTapClose() {
        self.removeDim()
    }
}

extension RefrigerPageViewController {
    @objc private func added() {
        selectedSort = .Added
        mainView.itemList = repository.fetchItemsInRefrigerator(rfID!, state: .refrigeration, sort: selectedSort)
    }
    @objc private func ExpFastest() {
        selectedSort = .ExpFastest
        mainView.itemList = repository.fetchItemsInRefrigerator(rfID!, state: .refrigeration, sort: selectedSort)
    }
    @objc private func ExpSlowest() {
        selectedSort = .ExpSlowest
        mainView.itemList = repository.fetchItemsInRefrigerator(rfID!, state: .refrigeration, sort: selectedSort)
    }
    @objc private func ExpiredGoods() {
        selectedSort = .ExpiredGoods
        mainView.itemList = repository.fetchItemsInRefrigerator(rfID!, state: .refrigeration, sort: selectedSort)
    }
}
