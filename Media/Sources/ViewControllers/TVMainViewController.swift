//
//  TVMainViewController.swift
//  Media
//
//  Created by hoon on 2023/08/20.
//

import UIKit


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
        
        
        callRequestToday()
        
    }
    
    
    
    
    @IBAction func segmenteValueChanged(_ sender: UISegmentedControl) {
        if sender.selectedSegmentIndex == 1 {
            tvList.removeAll()
            TmdbAPIManager.shared.callReqeustTVSeries(kind: .tvSeries_Popular) { data in
                for i in data.results {
                    let rate = i.voteAverage
                    let name = i.name
                    let overview = i.overview
                    let poster = i.posterPath
                    let id = i.id
                    let back = i.backdropPath
                    
                    let data = Tv(name: name, poster: poster ?? "empty", id: id, overview: overview, rate: String(rate), backdrop: back ?? "empty")
                    
                    self.tvList.append(data)
                }
            }
        } else {
            tvList.removeAll()
            callRequestToday()
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
        
        //값전달
        vc.tvId = tvList[indexPath.item].id
        vc.backDrop = tvList[indexPath.item].backdrop
        
        navigationController?.pushViewController(vc, animated: true)
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
        layout.itemSize = CGSize(width: width / 3, height: 210)
        layout.sectionInset = UIEdgeInsets(top: 16, left: spacing, bottom: 0, right: spacing) // CollectionView의 상하좌우 여백
        layout.minimumLineSpacing = 10
        layout.minimumInteritemSpacing = spacing
        
        collectionView.collectionViewLayout = layout
    }
    
    
}


//
extension TVMainViewController {
    func callRequestToday() {
        TmdbAPIManager.shared.callReqeustTVSeries(kind: .tvSeries_airingToday) { data in
            for i in data.results {
                let rate = i.voteAverage
                let name = i.name
                let overview = i.overview
                let poster = i.posterPath
                let id = i.id
                let back = i.backdropPath
                
                let data = Tv(name: name, poster: poster ?? "empty", id: id, overview: overview, rate: String(rate), backdrop: back ?? "empty")
                
                self.tvList.append(data)
            }
        }
    }
}
