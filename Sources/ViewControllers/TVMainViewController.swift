//
//  TVMainViewController.swift
//  Media
//
//  Created by hoon on 2023/08/20.
//

import UIKit

struct Tv {
    let name: String
    let poster: String
    let id: Int
    let overview: String
    let rate: String
    
    var contents: String {
        return "평점 : \(rate)"
    }
}

class TVMainViewController: UIViewController {

    var page: Int = 1
    
    lazy var tvList: [Tv] = [] {
        didSet{
            collectionView.reloadData()
        }
    }
    
    
    @IBOutlet var searchBar: UISearchBar!
    @IBOutlet var collectionView: UICollectionView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureCollectionView()
        configureCollectionViewLayout()
        
        settingButtonTVside()
        searchBar.delegate = self
        searchBar.isHidden = true
        
        
        TmdbManager.shared.callReqeust(kind: .tv_day, page: page) { data in
            for i in data.results {
                let rawRate = i.voteAverage
                let rate = String(format: "%.2f", rawRate)
                
                let title = i.title ?? i.name
                let data = Tv(name: title ?? "", poster: i.posterPath, id: i.id, overview: i.overview, rate: rate)
                
                self.tvList.append(data)
            }
        }
        
    }
    
    
    @IBAction func segmenteValueChanged(_ sender: UISegmentedControl) {
        if sender.selectedSegmentIndex == 1 {
            tvList.removeAll()
            TmdbManager.shared.callReqeust(kind: .tv_week, page: page) { data in
                for i in data.results {
                    let rawRate = i.voteAverage
                    let rate = String(format: "%.2f", rawRate)
                    
                    let title = i.title ?? i.name
                    let data = Tv(name: title ?? "", poster: i.posterPath, id: i.id, overview: i.overview, rate: rate)
                    
                    self.tvList.append(data)
                }
            }
        } else {
            tvList.removeAll()
            TmdbManager.shared.callReqeust(kind: .tv_day, page: page) { data in
                for i in data.results {
                    let rawRate = i.voteAverage
                    let rate = String(format: "%.2f", rawRate)
                    
                    let title = i.title ?? i.name
                    let data = Tv(name: title ?? "", poster: i.posterPath, id: i.id, overview: i.overview, rate: rate)
                    
                    self.tvList.append(data)
                }
            }
        }
    }
    
    
    
}


//searchBar
extension TVMainViewController: UISearchBarDelegate {
    func settingButtonTVside() {
        let searchButton = UIImage(systemName: "magnifyingglass")
        navigationItem.rightBarButtonItem = UIBarButtonItem.init(image: searchButton, style: .plain, target: self, action: #selector(searchButtonClickedTVside))
    }
    
    @objc
    func searchButtonClickedTVside(_ sender: UIBarButtonItem) {
        searchBar.isHidden.toggle()
    }
}


//CollectionView
extension TVMainViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return tvList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: TVCollectionViewCell.identifier, for: indexPath) as? TVCollectionViewCell else { return UICollectionViewCell() }
        
        let item = tvList[indexPath.item]
        cell.setCell(item: item)
        
        
        return cell
    }
    
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let sb = UIStoryboard(name: "Main", bundle: nil)
        let vc = sb.instantiateViewController(withIdentifier: TVDetailViewController.identifier) as! TVDetailViewController
        
        vc.tvId = tvList[indexPath.item].id
        
        let nav = UINavigationController(rootViewController: vc)
        nav.modalPresentationStyle = .fullScreen
        
        present(nav, animated: true)
    }
    
    
}


extension TVMainViewController: CollectionViewAttributeProtocol {
    func configureCollectionView() {
        collectionView.dataSource = self
        collectionView.delegate = self
        
        let nib = UINib(nibName: TVCollectionViewCell.identifier, bundle: nil)
        collectionView.register(nib, forCellWithReuseIdentifier: TVCollectionViewCell.identifier)
    }
    
    func configureCollectionViewLayout() {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        let spacing: CGFloat = 8
        let width = UIScreen.main.bounds.width - (spacing * 4)
        layout.scrollDirection = .vertical
        layout.itemSize = CGSize(width: width / 3, height: 210)
        layout.sectionInset = UIEdgeInsets(top: 16, left: spacing, bottom: 0, right: spacing) // CollectionView의 상하좌우 여백
        layout.minimumLineSpacing = 10
        layout.minimumInteritemSpacing = spacing
        
        collectionView.collectionViewLayout = layout
    }
    
    
}
