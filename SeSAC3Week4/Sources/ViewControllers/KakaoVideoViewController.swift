//
//  ViedeoViewController.swift
//  SeSAC3Week4
//
//  Created by hoon on 2023/08/08.
//

import UIKit
import Kingfisher

//struct Video {
//    let author: String
//    let date: String
//    let time: Int
//    let thumbnail: String
//    let title: String
//    let link: String
//
//    var contents: String {
//            return "\(author) | \(time)회\n\(date)"
//    }
//}

//
//UITableViewDataSourcePrefetching : iOS10이상 사용 가능한 프로토콜, cellForRowAt메서드가 호출되기 전에 미리 호출됨
class KakaoVideoViewController: UIViewController {


    @IBOutlet var searchBar: UISearchBar!
    @IBOutlet var videoTableview: UITableView!


    lazy var documentList: [Document] = [] {
        didSet {
            videoTableview.reloadData()
        }
    }
    //lazy var videoList: [Video] = []
    var page = 1 //스크롤 인식은 어떻게 하지? --> 담당 프로토콜 존재함
    var isEnd = false //현재 페이지가 마지막 페이지인지 점검하는 프로퍼티

    override func viewDidLoad() {
        super.viewDidLoad()
        videoTableview.delegate = self
        videoTableview.dataSource = self
        videoTableview.rowHeight = 140
        videoTableview.prefetchDataSource = self
        //callRequest() 필요없어짐

        searchBar.delegate = self
    }

//    func callRequest(query: String, page: Int) {
//        KakaoAPIManager.shared.callRequest(type: .video, query: query) { json in
//            print("=====\(json)")
//        }
//
//        //AF.request(url, method: .get, headers: header).validate(statusCode: 200...500).responseJSON { response in
//        switch response.result {
//        case .success(let value):
//            let json = JSON(value)
//            print("JSON: \(json)")
//
//            print(response.response?.statusCode) //상태코드가 몇번인지 정보를 받아볼 수 있음
//
//            let statusCode = response.response?.statusCode ?? 500 //statusCode가 안온다면 500번을 띄워라
//
//            if statusCode == 200 {
//
//                self.isEnd = json["meta"]["is_end"].boolValue //대부분 false이지만 true로 바뀌는 시점알아야됨 (page수 관련)
//
//
//                for item in json["documents"].arrayValue {
//
//                    let author = item["author"].stringValue
//                    let date = item["datetime"].stringValue
//                    let time = item["play_time"].intValue
//                    let thumbnail = item["thumbnail"].stringValue
//                    let title = item["title"].stringValue
//                    let link = item["link"].stringValue
//
//                    let data = Video(author: author, date: date, time: time, thumbnail: thumbnail, title: title, link: link)
//
//                    self.videoList.append(data)
//                }
//
//                self.videoTableview.reloadData()
//
//                print(self.videoList)
//            } else {
//                print("문제가 발생했어요. 잠시 후 다시 시도해주세요!")
//            }
//
//        case .failure(let error):
//            print(error)
//        }
//  }


}



extension KakaoVideoViewController: UITableViewDelegate, UITableViewDataSource, UITableViewDataSourcePrefetching  {

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: VideoTableViewCell.identifier) as? VideoTableViewCell else { return UITableViewCell()}
        //cell.titleLabel.text = videoList[indexPath.row].title
        cell.titleLabel.text = documentList[indexPath.row].title
        //cell.contentLabel.text = videoList[indexPath.row].contents
        cell.contentLabel.text = documentList[indexPath.row].contents
        if let url = URL(string: documentList[indexPath.row].thumbnail) {
            cell.thumbnailImageView.kf.setImage(with: url)
        }
        return cell
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return documentList.count
    }

    //UITableViewDataSourcePrefetching
    //셀이 화면에 보이기 직전에 필요한 리소스를 미리 다운 받는 기능
    //VideoList 갯수와 indexpath.row 위치를 비교해 마지막 스크롤 시점을 확인 -> 네트워크 요청 시도
    //카카오 제공 페이지 한도는 15이지만 컨텐츠마다 모두 15페이지는 넘지 않을 수도 있는 점 고려 -->
    func tableView(_ tableView: UITableView, prefetchRowsAt indexPaths: [IndexPath]) {
        for indexPath in indexPaths {
            if documentList.count - 1 == indexPath.row && page < 15 && !isEnd/*false라면*/ {
                page += 1
//                KakaoAPIManager.shared.callRequest(type: .video, query: searchBar.text!, page: page) { value in
//
//                    for i in value.documents {
//                        let data = Video(author: i.author, date: i.datetime, time: i.playTime, thumbnail: i.thumbnail, title: i.title, link: i.url)
//
//
//                        self.videoList.append(data)
//                    }
//
//                    self.videoTableview.reloadData()
//                }
                KakaoAPIManager.shared.callRequest(type: .video, query: searchBar.text!, page: page) { value in
                    
                    for i in value.documents {
                        let data = Document(author: i.author, datetime: i.datetime, playTime: i.playTime, thumbnail: i.thumbnail, title: i.title, url: i.url)
                        self.documentList.append(data)
                    }
                }
                
                
            }
        }
    }

    //취소 기능: 직접 취소하는 기능을 구현해주어야 함!
    //만약 스크롤을 빠르게 내리게 되면 굳이 데이터를 써가며 낭비하지 말고 취소하겠다고 동작한다.
    func tableView(_ tableView: UITableView, cancelPrefetchingForRowsAt indexPaths: [IndexPath]) {
        print("====취소: \(indexPaths)")
    }

}


extension KakaoVideoViewController: UISearchBarDelegate {
    //서치바 검색버튼
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {

        page = 1 //검색시 마다 page를 1로 초기화 해야된다., 새로운 검색어이기 때문에 page를 1로 변경
        documentList.removeAll()

        guard let query = searchBar.text else { return }
//        KakaoAPIManager.shared.callRequest(type: .video, query: searchBar.text!, page: page) { value in
//
//            for i in value.documents {
//                let data = Video(author: i.author, date: i.datetime, time: i.playTime, thumbnail: i.thumbnail, title: i.title, link: i.url)
//
//                self.videoList.append(data)
//            }
//
//            self.videoTableview.reloadData()
//        }
        KakaoAPIManager.shared.callRequest(type: .video, query: searchBar.text!, page: page) { value in
            
            for i in value.documents {
                let data = Document(author: i.author, datetime: i.datetime, playTime: i.playTime, thumbnail: i.thumbnail, title: i.title, url: i.url)
                self.documentList.append(data)
            }
        }
    }

}
