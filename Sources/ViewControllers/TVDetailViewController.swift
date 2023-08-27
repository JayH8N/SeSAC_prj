//
//  TVDetailViewController.swift
//  Media
//
//  Created by hoon on 2023/08/20.
//

import UIKit

struct List {
    let title: String
    let poster: String
}



class TVDetailViewController: UIViewController {

    let segmentControl = UISegmentedControl(items: ["S/R", "Videos"])
    
    lazy var similar: Similar = Similar(page: 0, results: [], totalPages: 0, totalResults: 0)
    lazy var recommendation: Similar = Similar(page: 0, results: [], totalPages: 0, totalResults: 0)
    
    
    
    var tvId = 0
    var backDrop: String?
    var page = 1
    
    @IBOutlet var posterImageView: UIImageView!
    @IBOutlet var similarCollectionView: UICollectionView!
    @IBOutlet var recoCollectionView: UICollectionView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setSegment()
        callRequest()
        setView()
        //collectionView
        configureCollectionView()
        configureCollectionViewLayout()
    }
    
    func setSegment() {
        navigationItem.titleView = segmentControl
        segmentControl.selectedSegmentIndex = 0
    }
    
    func setView() {
        var posterURL = backDrop
        if posterURL == "empty" {
            posterURL = URL.emptyImage
        } else {
            posterURL = URL.imageBaseURL + backDrop!
        }
        
        if let url = URL(string: posterURL ?? URL.emptyImage) {
            posterImageView.kf.setImage(with: url)
        }
    }
    
    
    
    
    
    
    func callRequest() {
        similar.results.removeAll()
        recommendation.results.removeAll()
        
        let group = DispatchGroup()
        
        group.enter()
        //similar
        TmdbAPIManager.shared.callReqeustTVSeries2(kind: .tv, id: tvId, page: page, option: .similar) { data in
            self.similar = data
            print("===11111111\(data)")
            group.leave()
        }
        
        //Recommendations
        group.enter()
        TmdbAPIManager.shared.callReqeustTVSeries2(kind: .tv, id: tvId, page: page, option: .recommendations) { data in
            self.recommendation = data
            print("===22222222\(data)")
            group.leave()
        }
        
        group.notify(queue: .main) {
            self.similarCollectionView.reloadData()
            self.recoCollectionView.reloadData()
        }
    }

    
    
  

}

extension TVDetailViewController: UICollectionViewDelegate, UICollectionViewDataSource {

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return collectionView == similarCollectionView ? similar.results.count : recommendation.results.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: TVCollectionViewCell.identifier, for: indexPath) as? TVCollectionViewCell else { return UICollectionViewCell() }
        
        let itemSimilar = similar.results[indexPath.item]
        let itemRecommendation = recommendation.results[indexPath.item]
        
        if collectionView == similarCollectionView {
            let url = URL.imageBaseURL + (itemSimilar.posterPath ?? "")
            cell.posterImageView.kf.setImage(with: URL(string: url))
            cell.titleLabel.text = itemSimilar.name
            let rawRate = itemSimilar.voteAverage
            let rate = String(format: "%.2f", rawRate)
            cell.infoLabel.text = "rate: \(rate)"
        } else {
            let url = URL.imageBaseURL + (itemRecommendation.posterPath ?? URL.emptyImage)
            cell.posterImageView.kf.setImage(with: URL(string: url))
            cell.titleLabel.text = itemRecommendation.name
            let rawRate = itemRecommendation.voteAverage
            let rate = String(format: "%.2f", rawRate)
            cell.infoLabel.text = "rate: \(rate)"
        }

        return cell
    }
    
    
}

extension TVDetailViewController: CollectionViewAttributeProtocol {
    func configureCollectionView() {
        similarCollectionView.dataSource = self
        similarCollectionView.delegate = self
        
        recoCollectionView.dataSource = self
        recoCollectionView.delegate = self
        
        let nib = UINib(nibName: TVCollectionViewCell.identifier, bundle: nil)
        similarCollectionView.register(nib, forCellWithReuseIdentifier: TVCollectionViewCell.identifier)
        recoCollectionView.register(nib, forCellWithReuseIdentifier: TVCollectionViewCell.identifier)
    }
    
    func configureCollectionViewLayout() {
        let layout = UICollectionViewFlowLayout()
        let spacing: CGFloat = 16
        layout.scrollDirection = .horizontal
        layout.itemSize = CGSize(width: 100, height: 180)
        layout.sectionInset = UIEdgeInsets(top: 4, left: spacing, bottom: 4, right: spacing) // CollectionView의 상하좌우 여백
        layout.minimumLineSpacing = 10
        layout.minimumInteritemSpacing = spacing
        
        similarCollectionView.collectionViewLayout = layout
        recoCollectionView.collectionViewLayout = layout
    }
    
    
    
    
}
