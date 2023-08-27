//
//  DetailViewController.swift
//  Media
//
//  Created by hoon on 2023/08/20.
//

import UIKit
import Kingfisher

struct CastInfo {
    var image: String
    var name: String
    var character: String
}


class DetailViewController: UIViewController {
    
    
    
    var movieId: Int = 0
    var backPoster: String = ""
    var mainPoster: String = ""
    var movieTitle: String = ""
    var overview: String = ""
    
    lazy var creditList: [CastInfo] = [] {
        didSet {
            tableView.reloadData()
        }
    }
    
    @IBOutlet var movieTitleLabel: UILabel!
    @IBOutlet var moviePoster: UIImageView!
    @IBOutlet var movieBackPoster: UIImageView!
    @IBOutlet var overViewTitle: UILabel!
    @IBOutlet var overViewTextView: UITextView!
    
    @IBOutlet var tableView: UITableView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "Case/Info"
        setTablaView()
        setView()
        setValue()
        TmdbAPIManager.shared.callRequstCast(id: movieId) { value in
            for i in value.cast {
                let data = CastInfo(image: i.profilePath ?? "", name: i.name, character: i.character ?? "")
                
                self.creditList.append(data)
            }
        }
    }
    
    func setTablaView() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.rowHeight = 114
    }
    
    func setView() {
        movieTitleLabel.textColor = .white
        movieTitleLabel.font = .boldSystemFont(ofSize: 24)
        overViewTitle.text = "OverView"
        overViewTitle.textColor = .lightGray
        overViewTitle.font = .boldSystemFont(ofSize: 15)
        overViewTextView.layer.addBorder([.top], width: 0.7, color: UIColor.lightGray.cgColor)
    }
    
    func setValue() {
        let imageURL = "https://image.tmdb.org/t/p/w500"
        if let url = URL(string: imageURL + backPoster) {
            movieBackPoster.kf.setImage(with: url)
        }
        if let url = URL(string: imageURL + mainPoster) {
            moviePoster.kf.setImage(with: url)
        }
        
        movieTitleLabel.text = movieTitle
        
        overViewTextView.text = overview
    }
    
    func forwardValue(data: TmdbData) {
        movieId = data.id
        backPoster = data.backdropPath
        mainPoster = data.posterPath
        movieTitle = data.title
        overview = data.overview
    }
    
    
    
    

}


extension DetailViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "Cast"
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return creditList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: CastTableViewCell.identifier) as! CastTableViewCell
        
        let row = creditList[indexPath.row]
        
        cell.setCell(row: row)
        
        return cell
    }
    
    
}
