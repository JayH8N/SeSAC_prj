//
//  ViewController.swift
//  Media
//
//  Created by hoon on 2023/08/19.
//

import UIKit


struct TmdbData {
    var releaseDate: String
    var genreIDS: [Int]
    var voteAverage: String
    var title: String
    var overview: String
    var backdropPath: String
    var posterPath: String
    var id: Int
}

class MainViewController: UIViewController {
    
    
    @IBOutlet var searchBar: UISearchBar!
    @IBOutlet var tableView: UITableView!
    
    lazy var list: [TmdbData] = [] {
        didSet {
            tableView.reloadData()
        }
    }
    
    lazy var genre: [Int:String] = [:]
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //tableView
        tableViewDelegate()
        registerNib()
        
        //searchBar
        settingButton()
        searchBar.delegate = self
        searchBar.isHidden = true
        
        //API호출
        TmdbManager.shared.callReqeust(kind: .movies_week) { data in
            
            TmdbManager.shared.callGenres(kind: .movie_genre) { jenre in
                
                for i in jenre.genres {
                    let id = i.id
                    let name = i.name
                    
                    self.genre[id] = name
                }
                
                for item in data.results {
                    let rawRate = item.voteAverage
                    let rate = String(format: "%.2f", rawRate)
                    
                    let title = item.title ?? item.name
                    let rawDate = item.releaseDate ?? item.firstAirDate
                    let newDate = self.convertDateFormat(rawDate ?? "0000-00-00", from: "yyyy-MM-dd", to: "MM/dd/yyyy")
                    
                    
                    let data = TmdbData(releaseDate: newDate ?? "", genreIDS: item.genreIDS, voteAverage: rate, title: title ?? "", overview: item.overview, backdropPath: item.backdropPath, posterPath: item.posterPath, id: item.id)
                    
                    self.list.append(data)
                }
            }
        }
    }
    
    //날짜 형변환 함수
    func convertDateFormat(_ inputDate: String, from inputFormat: String, to outputFormat: String) -> String? {
        let inputFormatter = DateFormatter()
        inputFormatter.dateFormat = inputFormat
        
        guard let date = inputFormatter.date(from: inputDate) else {
            return nil
        }

        let outputFormatter = DateFormatter()
        outputFormatter.dateFormat = outputFormat
        return outputFormatter.string(from: date)
    }
    
    
    
    
    


}
