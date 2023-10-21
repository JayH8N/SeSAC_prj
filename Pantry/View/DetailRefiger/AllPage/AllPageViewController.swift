//
//  AllPageViewController.swift
//  Pantry
//
//  Created by hoon on 2023/10/09.
//

import UIKit
import BarcodeScanner
import Toast
import RealmSwift

class AllPageViewController: BaseViewController {
    
    var rfID: ObjectId?
    
    let mainView = AllPageView()
    let repository = RefrigeratorRepository()
    
    override func loadView() {
        view = mainView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        mainView.switchDelegate = self
        mainView.delegate = self
        
        mainView.itemList = repository.fetchItem(rfObjectid: rfID!)
        
        NotificationCenter.default.addObserver(self, selector: #selector(reloadData), name: Notification.Name("itemReload"), object: nil)
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

extension AllPageViewController: BulletinDelegate {
    func onTapClose() {
        self.removeDim()
    }
}

extension AllPageViewController: SwitchScreenProtocol, NavPushProtocol {
    func pushView(vc: UIViewController) {
        navigationController?.pushViewController(vc, animated: true)
    }
    
    func switchScreen(nav: UINavigationController) {
        present(nav, animated: true)
    }
    
}
