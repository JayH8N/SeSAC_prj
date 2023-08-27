//
//  ViewController.swift
//  Media
//
//  Created by hoon on 2023/08/19.
//

import UIKit


struct TmdbData {
    let releaseDate: String
    let genreIDS: [Int]
    let voteAverage: String
    let title: String
    let overview: String
    let backdropPath: String
    let posterPath: String
    let originalTitle: String
    let id: Int
}

class MainViewController: UIViewController {
    
    var page: Int = 1
    
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
        
        //API
        TmdbManager.shared.callReqeust(kind: .movies_day, page: page) { data in
            
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
                    
                    
                    let data = TmdbData(releaseDate: newDate ?? "", genreIDS: item.genreIDS, voteAverage: rate, title: title ?? "", overview: item.overview, backdropPath: item.backdropPath, posterPath: item.posterPath, originalTitle: item.originalTitle ?? "", id: item.id)
                    
                    self.list.append(data)
                }
            }
        }
        
    }
    
    
    override func awakeAfter(using coder: NSCoder) -> Any? {
            navigationItem.backButtonDisplayMode = .minimal
            return super.awakeAfter(using: coder)
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
    
    //segmentedControl
    @IBAction func segmenteValueChanged(_ sender: UISegmentedControl) {
        if sender.selectedSegmentIndex == 1 {
            list.removeAll()
            TmdbManager.shared.callReqeust(kind: .movies_week, page: page) { data in
                for item in data.results {
                    let rawRate = item.voteAverage
                    let rate = String(format: "%.2f", rawRate)
                    
                    let title = item.title ?? item.name
                    let rawDate = item.releaseDate ?? item.firstAirDate
                    let newDate = self.convertDateFormat(rawDate ?? "0000-00-00", from: "yyyy-MM-dd", to: "MM/dd/yyyy")
                    
                    
                    let data = TmdbData(releaseDate: newDate ?? "", genreIDS: item.genreIDS, voteAverage: rate, title: title ?? "", overview: item.overview, backdropPath: item.backdropPath, posterPath: item.posterPath, originalTitle: item.originalTitle ?? "", id: item.id)
                    
                    self.list.append(data)
                }
            }
        } else {
            list.removeAll()
            TmdbManager.shared.callReqeust(kind: .movies_day, page: page) { data in
                for item in data.results {
                    let rawRate = item.voteAverage
                    let rate = String(format: "%.2f", rawRate)
                    
                    let title = item.title ?? item.name
                    let rawDate = item.releaseDate ?? item.firstAirDate
                    let newDate = self.convertDateFormat(rawDate ?? "0000-00-00", from: "yyyy-MM-dd", to: "MM/dd/yyyy")
                    
                    
                    let data = TmdbData(releaseDate: newDate ?? "", genreIDS: item.genreIDS, voteAverage: rate, title: title ?? "", overview: item.overview, backdropPath: item.backdropPath, posterPath: item.posterPath, originalTitle: item.originalTitle ?? "", id: item.id)
                    
                    self.list.append(data)
                }
            }
            
        }
    }
    


}


//tavleViewCell 등록
extension MainViewController: TableViewAttributeProtocol {
    func tableViewDelegate() {
        tableView.dataSource = self
        tableView.delegate = self
    }
    
    func registerNib() {
        let nib = UINib(nibName: MainViewTableViewCell.identifier, bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: MainViewTableViewCell.identifier)
    }
}

//tableView
extension MainViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 430
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return list.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: MainViewTableViewCell.identifier) as? MainViewTableViewCell else { return UITableViewCell() }
        
        cell.setCelldata(data: list[indexPath.row])
        cell.genreLabel.text = "#\(genre[list[indexPath.row].genreIDS[0]]!)"
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let sb = UIStoryboard(name: "Main", bundle: nil)
        let vc = sb.instantiateViewController(withIdentifier: DetailViewController.identifier) as! DetailViewController
        
        let row = list[indexPath.row]
        
        vc.forwardValue(data: row)
        
        navigationController?.pushViewController(vc, animated: true)
        
        tableView.reloadRows(at: [indexPath], with: .none)
    }
    

}


//searchBar
extension MainViewController: UISearchBarDelegate {
    func settingButton() {
        let searchButton = UIImage(systemName: "magnifyingglass")
        navigationItem.rightBarButtonItem = UIBarButtonItem.init(image: searchButton, style: .plain, target: self, action: #selector(searchButtonClicked))
    }
    
    @objc
    func searchButtonClicked(_ sender: UIBarButtonItem) {
        searchBar.isHidden.toggle()
    }
}
