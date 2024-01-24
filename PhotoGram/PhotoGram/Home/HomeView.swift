//
//  HomeView.swift
//  PhotoGram
//
//  Created by hoon on 2023/08/31.
//

import UIKit


class HomeView: BaseView {
    
    //✅ 2. delegate 값전달(화면전환)
    weak var delegate: HomeViewProtocol?
    
    deinit {
        print(self, #function)
    }
    
    lazy var collectionView = {
        let view = UICollectionView(frame: .zero, collectionViewLayout: collectionViewLayout())
        view.register(SearchCollectionViewCell.self, forCellWithReuseIdentifier: "SearchCollectionViewCell")
//        view.dataSource = self
//        view.delegate = self
        return view
    }()
    
    private func collectionViewLayout() -> UICollectionViewLayout {
        let layout = UICollectionViewFlowLayout()
        layout.minimumLineSpacing = 8
        layout.minimumInteritemSpacing = 8
        layout.sectionInset = UIEdgeInsets(top: 0, left: 8, bottom: 0, right: 8)
        let size = UIScreen.main.bounds.width - 32 //self.frame.width
        layout.itemSize = CGSize(width: size / 3, height: size / 3)
        return layout
    }

    
    override func configureView() {
        addSubview(collectionView)
    }
    
    override func setConstraints() {
        collectionView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }

    
    
}


//extension HomeView: UICollectionViewDelegate, UICollectionViewDataSource {
//    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
//        return 100
//    }
//
//    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
//        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "SearchCollectionViewCell", for: indexPath) as? SearchCollectionViewCell else { return UICollectionViewCell() }
//        
//        cell.imageView.backgroundColor = .systemBlue
//
//        return cell
//    }
//
//    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
//        print(#function)
//
//        //화면전환 안됨, Alert도 못띄움(?안되는 이유 => ViewController가 아니라서) => 커스텀 프로토콜을 통해 해결
//
//        //✅ 3. delegate 값전달(화면전환)
//        delegate?.didselectItemAt(indexPath: indexPath)
//    }
//
//
//}
