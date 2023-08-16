//
//  ViewController.swift
//  SeSAC3Week4
//
//  Created by hoon on 2023/08/07.
//

import UIKit
import Alamofire
import SwiftyJSON

struct Movie {
    var title: String
    var release: String
}






class ViewController: UIViewController {

    @IBOutlet var searchBar: UISearchBar!
    @IBOutlet var movieTableView: UITableView!
    @IBOutlet var indicatorView: UIActivityIndicatorView!
    
    var movieList: [Movie] = []
    //codable
    var result: BoxOffice?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        movieTableView.delegate = self
        movieTableView.dataSource = self
        movieTableView.rowHeight = 60
        indicatorView.isHidden = true
    }
    
    //예시 인증키 = f5eef3421c602c6cb7ea224104795888
    func callRequest(date: String) {
        
        indicatorView.startAnimating() //애니메이션
        indicatorView.isHidden = false
        
        let url = "http://kobis.or.kr/kobisopenapi/webservice/rest/boxoffice/searchDailyBoxOfficeList.json?key=\(APIKey.boxOfficeKey)&targetDt=\(date)" //인증키와 targetDt의 정보를 가지고 서버에 요청
        AF.request(url, method: .get).validate()
            .responseDecodable(of: BoxOffice.self) { response in
                print(response.value)
               self.result = response.value
            }
//            .responseJSON { response in
//            switch response.result {
//            case .success(let value):
//                let json = JSON(value)
//                print("JSON: \(json)")
//
//
//                for item in json["boxOfficeResult"]["dailyBoxOfficeList"].arrayValue {
//                    let movieNm = item["movieNm"].stringValue
//                    let openDt = item["openDt"].stringValue
//                    let data = Movie(title: movieNm, release: openDt) //❗️
//                    self.movieList.append(data) //❗️
//                }
//                self.indicatorView.stopAnimating() //통신이 끝나면 hidden처리되기에 stopAnimating을 굳이 해야될까 싶지만 계속 돌아가기에 멈춰지는것도 필요
//                self.indicatorView.isHidden = true
//                self.movieTableView.reloadData()
//
//            case .failure(let error):
//                print(error)
//            }
//        }
        
        
        
        
    }
    
    
    
    
    
}


extension ViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return result?.boxOfficeResult.dailyBoxOfficeList.count ?? 0//movieList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "movieCell")!
        cell.textLabel?.text = movieList[indexPath.row].title
        cell.detailTextLabel?.text = movieList[indexPath.row].release
        
        return cell
    }
}

extension ViewController: UISearchBarDelegate {
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        
        //20220101 --> 1.8글자 2.20233333 옳바른 날짜 형식인지 3. 날짜의 범위(영지위는 어제까지의 데이터만제공)
        callRequest(date: searchBar.text!)
        
        
    }
}
