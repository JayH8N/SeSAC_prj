//
//  HomeViewController.swift
//  PhotoGram
//
//  Created by hoon on 2023/08/31.
//

import UIKit

//✅ 1. delegate 값전달(화면전환)
protocol HomeViewProtocol: AnyObject { //AnyObject : 클래스에서만 채택될수 있도록 함
    func didselectItemAt(indexPath: IndexPath)
}


class HomeViewController: BaseViewController {
    
    
    
    var list: Photo = Photo(total: 0, total_pages: 0, results: [])
    
    let mainView = HomeView()
    
    override func loadView() {
        //✅ 4. delegate 값전달(화면전환)
        mainView.delegate = self
        view = mainView
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print(self, #function)
        
        mainView.collectionView.delegate = self
        mainView.collectionView.dataSource = self
        
        APIServie.shared.callRequest(type: .search, keyword: "sky") { photo in
            
            guard let photo = photo else {
                print("Alert ERROR")
                return
            }
            print("API END")
            self.list = photo //네트워크 전후로 데이터가 변경됨.
            

            self.mainView.collectionView.reloadData()
            
        }
    }
    
    deinit {
        print(self, #function)
    }
    
    
    override func configureView() {
        super.configureView()
    }
    
    
    
    
    override func setConstraints() {
        super.setConstraints()
    }
    
    
    
    
    
    
    
}

extension HomeViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        print(#function)
        return list.results.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "SearchCollectionViewCell", for: indexPath) as? SearchCollectionViewCell else { return UICollectionViewCell() }
        
        cell.imageView.backgroundColor = .systemBlue
        
        let thumb = list.results[indexPath.item].urls.thumb
        
        let url = URL(string: thumb) //링크를 기반으로 이미지를 보여준다? >>>> 네트워크 통신임!
        
        
        DispatchQueue.global().async {
            
            let data = try! Data(contentsOf: url!) //동기 코드
            
            DispatchQueue.main.async {
                cell.imageView.image = UIImage(data: data)
            }
        }
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print(#function)
        
        //화면전환 안됨, Alert도 못띄움(?안되는 이유 => ViewController가 아니라서) => 커스텀 프로토콜을 통해 해결

    }
}

extension HomeViewController: HomeViewProtocol {
    
    func didselectItemAt(indexPath: IndexPath) {
        navigationController?.popViewController(animated: true)
    }
}
