//
//  TVMainViewController.swift
//  Media
//
//  Created by hoon on 2023/08/20.
//

import UIKit

struct TvSeries {
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

    
    lazy var tvList: [TvSeries] = [] {
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
        
        TmdbManager.shared.callReqeust(kind: .tv_day) { data in
            for i in data.results {
                let rawRate = i.voteAverage
                let rate = String(format: "%.2f", rawRate)
                
                let data = TvSeries(name: i.name ?? "", poster: i.posterPath, id: i.id, overview: i.overview, rate: rate)
                
                self.tvList.append(data)
            }
        }
    }
    
    
    @IBAction func segmenteValueChanged(_ sender: UISegmentedControl) {
        if sender.selectedSegmentIndex == 1 {
            tvList.removeAll()
            TmdbManager.shared.callReqeust(kind: .tv_week) { data in
                for i in data.results {
                    let rawRate = i.voteAverage
                    let rate = String(format: "%.2f", rawRate)
                    
                    let data = TvSeries(name: i.name ?? "", poster: i.posterPath, id: i.id, overview: i.overview, rate: rate)
                    
                    self.tvList.append(data)
                }
            }
        } else {
            tvList.removeAll()
            TmdbManager.shared.callReqeust(kind: .tv_day) { data in
                for i in data.results {
                    let rawRate = i.voteAverage
                    let rate = String(format: "%.2f", rawRate)
                    
                    let data = TvSeries(name: i.name ?? "", poster: i.posterPath, id: i.id, overview: i.overview, rate: rate)
                    
                    self.tvList.append(data)
                }
            }
        }
    }
    
    
    

    

}
