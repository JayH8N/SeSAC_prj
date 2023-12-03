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
        mainView.homeCollectionView.delegate = self
        mainView.homeCollectionView.dataSource = self
    }
    
    deinit {
        print("====\(Self.self)====Deinit")
    }
    
}

extension HomeVC: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        5
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: HomeCell().description, for: indexPath)
        
        return cell
    }
    
}
