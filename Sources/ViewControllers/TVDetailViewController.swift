//
//  TVDetailViewController.swift
//  Media
//
//  Created by hoon on 2023/08/20.
//

import UIKit





class TVDetailViewController: UIViewController {

    @IBOutlet var collectionView: UICollectionView!
    
    
    let segmentControl = UISegmentedControl(items: ["Similar", "출연"])
    
    lazy var similar: [TmdbData] = []
    lazy var castList: [CastInfo] = []
    
    var tvId = 0
    var page = 1
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setXmark()
        setSegment()
        callRequest()
        print(similar)
        print(castList)
    }
    
    func setXmark() {
        let xmark = UIImage(systemName: "xmark")
        navigationItem.leftBarButtonItem = UIBarButtonItem.init(image: xmark, style: .plain, target: self, action: #selector(closeButtonClicked))
        navigationItem.leftBarButtonItem?.tintColor = .black
    }
    
    @objc
    func closeButtonClicked(_ sender: UIBarButtonItem) {
        dismiss(animated: true)
    }
    
    func setSegment() {
        navigationItem.titleView = segmentControl
        segmentControl.selectedSegmentIndex = 0
    }
    
    func callRequest() {
        
        TmdbManager.shared.callReqeustTVSeries(id: tvId, tvOption: .similar, page: page) { value in
            for item in value.results {
                let data = TmdbData(releaseDate: item.releaseDate ?? "", genreIDS: item.genreIDS, voteAverage: "\(item.voteAverage)", title: item.title ?? "", overview: item.overview, backdropPath: item.backdropPath, posterPath: item.posterPath, originalTitle: item.originalTitle ?? "", id: item.id)
                
                self.similar.append(data)
            }
        }
        
        TmdbManager.shared.callRequstCast(id: tvId) { value in
            for item in value.cast {
                let data = CastInfo(image: item.profilePath ?? "", name: item.name, character: item.character ?? "")
                
                self.castList.append(data)
            }
        }
        
    }

    
    
  

}
