//
//  HomeVC.swift
//  SeSACgram
//
//  Created by hoon on 11/14/23.
//

import UIKit

final class HomeVC: BaseVC {
    
    private let mainView = HomeView()
    
    
    override func loadView() {
        self.view = mainView
    }
    
    override func setNavigationBar() {
        navigationItem.leftBarButtonItem = UIBarButtonItem(customView: mainView.appNameLabel)
        navigationController?.hidesBarsOnSwipe = true
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        NotificationCenter.default.addObserver(self, selector: #selector(reloadHome), name: Notification.Name.homeReload, object: nil)
        mainView.homeCollectionView.delegate = self
        mainView.homeCollectionView.dataSource = self
        addTargets()
    }
    
    deinit {
        print("====\(Self.self)====Deinit")
    }
    
    private func reloadData() {
        mainView.homeCollectionView.reloadData()
    }
    
    @objc private func reloadHome() {
        self.reloadData()
    }
    
}

extension HomeVC: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        5
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: HomeCell().description, for: indexPath) as! HomeCell
        cell.presentDelegate = self
        return cell
    }
    
}

extension HomeVC: ModalDelegate {
    func presnet() {
        let vc = CommentVC()
        let nav = UINavigationController(rootViewController: vc)
        let detentIdentifier = UISheetPresentationController.Detent.Identifier("customDetent")
        let customDetent = UISheetPresentationController.Detent.custom(identifier: detentIdentifier) { _ in
            let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene
            let safeAreaBottom = windowScene?.windows.first?.safeAreaInsets.bottom ?? 0

            return 600 - safeAreaBottom
        }

        if let sheet = nav.sheetPresentationController {
            sheet.detents = [customDetent, .large()]
            sheet.largestUndimmedDetentIdentifier = nil //sheet뒷 배경 상호작용 및 음영처리, default: nil
            sheet.prefersGrabberVisible = true
            sheet.prefersScrollingExpandsWhenScrolledToEdge = false
        }
        present(nav, animated: true)
    }
}

extension HomeVC: AddTargetProtocol {
    func addTargets() {
        mainView.refresh.addTarget(self, action: #selector(refreshData), for: .valueChanged)
    }
    
    @objc private func refreshData() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
            //api요청 후 reloadData
            self.mainView.refresh.endRefreshing()
        }
    }
}
