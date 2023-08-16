//
//  ViedeoViewController.swift
//  SeSAC3Week4
//
//  Created by hoon on 2023/08/08.
//

import UIKit
import Alamofire
import SwiftyJSON
import Kingfisher

struct Video {
    let author: String
    let date: String
    let time: Int
    let thumbnail: String
    let title: String
    let link: String

    var contents: String {
            return "\(author) | \(time)회\n\(date)"
    }

}


//UITableViewDataSourcePrefetching : iOS10이상 사용 가능한 프로토콜, cellForRowAt메서드가 호출되기 전에 미리 호출됨
class VideoViewController: UIViewController {


    @IBOutlet var searchBar: UISearchBar!
    @IBOutlet var videoTableview: UITableView!



    var videoList: [Video] = []
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



extension VideoViewController: UITableViewDelegate, UITableViewDataSource, UITableViewDataSourcePrefetching  {

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: VideoTableViewCell.identifier) as? VideoTableViewCell else { return UITableViewCell()}
        cell.titleLabel.text = videoList[indexPath.row].title
        cell.contentLabel.text = videoList[indexPath.row].contents
        if let url = URL(string: videoList[indexPath.row].thumbnail) {
            cell.thumbnailImageView.kf.setImage(with: url)
        }
        return cell
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return videoList.count
    }

    //UITableViewDataSourcePrefetching
    //셀이 화면에 보이기 직전에 필요한 리소스를 미리 다운 받는 기능
    //VideoList 갯수와 indexpath.row 위치를 비교해 마지막 스크롤 시점을 확인 -> 네트워크 요청 시도
    //카카오 제공 페이지 한도는 15이지만 컨텐츠마다 모두 15페이지는 넘지 않을 수도 있는 점 고려 -->
    func tableView(_ tableView: UITableView, prefetchRowsAt indexPaths: [IndexPath]) {
        for indexPath in indexPaths {
            if videoList.count - 1 == indexPath.row && page < 15 && !isEnd/*false라면*/ {
                page += 1
                //callRequest(query: searchBar.text!, page: page)
                KakaoAPIManager.shared.callRequest(type: .video, query: searchBar.text!, page: page) { value in
                    
                    for i in value.documents {
                        let data = Video(author: i.author.rawValue, date: i.datetime, time: i.playTime, thumbnail: i.thumbnail, title: i.title, link: i.url)
                        
                        self.videoList.append(data)
                    }
                    
                    self.videoTableview.reloadData()
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


extension VideoViewController: UISearchBarDelegate {
    //서치바 검색버튼
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {

        page = 1 //검색시 마다 page를 1로 초기화 해야된다., 새로운 검색어이기 때문에 page를 1로 변경
        videoList.removeAll()

        guard let query = searchBar.text else { return }
        KakaoAPIManager.shared.callRequest(type: .video, query: searchBar.text!, page: page) { value in
            
            for i in value.documents {
                let data = Video(author: i.author.rawValue, date: i.datetime, time: i.playTime, thumbnail: i.thumbnail, title: i.title, link: i.url)
                
                self.videoList.append(data)
            }
            
            self.videoTableview.reloadData()
        }
    }

}


// MARK: - KakaoVideo
struct KakaoVideo: Codable {
    let documents: [Document]
    let ds, g: [JSONAny]
    let m: M
    let meta: Meta
}

// MARK: - Document
struct Document: Codable {
    let author: Author
    let datetime: String
    let playTime: Int
    let thumbnail: String
    let title: String
    let url: String

    enum CodingKeys: String, CodingKey {
        case author, datetime
        case playTime = "play_time"
        case thumbnail, title, url
    }
}

enum Author: String, Codable {
    case 이지금IUOfficial = "이지금 [IU Official]"
}

// MARK: - M
struct M: Codable {
}

// MARK: - Meta
struct Meta: Codable {
    let isEnd: Bool
    let pageableCount, totalCount: Int

    enum CodingKeys: String, CodingKey {
        case isEnd = "is_end"
        case pageableCount = "pageable_count"
        case totalCount = "total_count"
    }
}

// MARK: - Encode/decode helpers

class JSONNull: Codable, Hashable {

    public static func == (lhs: JSONNull, rhs: JSONNull) -> Bool {
        return true
    }

    public var hashValue: Int {
        return 0
    }

    public init() {}

    public required init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        if !container.decodeNil() {
            throw DecodingError.typeMismatch(JSONNull.self, DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Wrong type for JSONNull"))
        }
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        try container.encodeNil()
    }
}

class JSONCodingKey: CodingKey {
    let key: String

    required init?(intValue: Int) {
        return nil
    }

    required init?(stringValue: String) {
        key = stringValue
    }

    var intValue: Int? {
        return nil
    }

    var stringValue: String {
        return key
    }
}

class JSONAny: Codable {

    let value: Any

    static func decodingError(forCodingPath codingPath: [CodingKey]) -> DecodingError {
        let context = DecodingError.Context(codingPath: codingPath, debugDescription: "Cannot decode JSONAny")
        return DecodingError.typeMismatch(JSONAny.self, context)
    }

    static func encodingError(forValue value: Any, codingPath: [CodingKey]) -> EncodingError {
        let context = EncodingError.Context(codingPath: codingPath, debugDescription: "Cannot encode JSONAny")
        return EncodingError.invalidValue(value, context)
    }

    static func decode(from container: SingleValueDecodingContainer) throws -> Any {
        if let value = try? container.decode(Bool.self) {
            return value
        }
        if let value = try? container.decode(Int64.self) {
            return value
        }
        if let value = try? container.decode(Double.self) {
            return value
        }
        if let value = try? container.decode(String.self) {
            return value
        }
        if container.decodeNil() {
            return JSONNull()
        }
        throw decodingError(forCodingPath: container.codingPath)
    }

    static func decode(from container: inout UnkeyedDecodingContainer) throws -> Any {
        if let value = try? container.decode(Bool.self) {
            return value
        }
        if let value = try? container.decode(Int64.self) {
            return value
        }
        if let value = try? container.decode(Double.self) {
            return value
        }
        if let value = try? container.decode(String.self) {
            return value
        }
        if let value = try? container.decodeNil() {
            if value {
                return JSONNull()
            }
        }
        if var container = try? container.nestedUnkeyedContainer() {
            return try decodeArray(from: &container)
        }
        if var container = try? container.nestedContainer(keyedBy: JSONCodingKey.self) {
            return try decodeDictionary(from: &container)
        }
        throw decodingError(forCodingPath: container.codingPath)
    }

    static func decode(from container: inout KeyedDecodingContainer<JSONCodingKey>, forKey key: JSONCodingKey) throws -> Any {
        if let value = try? container.decode(Bool.self, forKey: key) {
            return value
        }
        if let value = try? container.decode(Int64.self, forKey: key) {
            return value
        }
        if let value = try? container.decode(Double.self, forKey: key) {
            return value
        }
        if let value = try? container.decode(String.self, forKey: key) {
            return value
        }
        if let value = try? container.decodeNil(forKey: key) {
            if value {
                return JSONNull()
            }
        }
        if var container = try? container.nestedUnkeyedContainer(forKey: key) {
            return try decodeArray(from: &container)
        }
        if var container = try? container.nestedContainer(keyedBy: JSONCodingKey.self, forKey: key) {
            return try decodeDictionary(from: &container)
        }
        throw decodingError(forCodingPath: container.codingPath)
    }

    static func decodeArray(from container: inout UnkeyedDecodingContainer) throws -> [Any] {
        var arr: [Any] = []
        while !container.isAtEnd {
            let value = try decode(from: &container)
            arr.append(value)
        }
        return arr
    }

    static func decodeDictionary(from container: inout KeyedDecodingContainer<JSONCodingKey>) throws -> [String: Any] {
        var dict = [String: Any]()
        for key in container.allKeys {
            let value = try decode(from: &container, forKey: key)
            dict[key.stringValue] = value
        }
        return dict
    }

    static func encode(to container: inout UnkeyedEncodingContainer, array: [Any]) throws {
        for value in array {
            if let value = value as? Bool {
                try container.encode(value)
            } else if let value = value as? Int64 {
                try container.encode(value)
            } else if let value = value as? Double {
                try container.encode(value)
            } else if let value = value as? String {
                try container.encode(value)
            } else if value is JSONNull {
                try container.encodeNil()
            } else if let value = value as? [Any] {
                var container = container.nestedUnkeyedContainer()
                try encode(to: &container, array: value)
            } else if let value = value as? [String: Any] {
                var container = container.nestedContainer(keyedBy: JSONCodingKey.self)
                try encode(to: &container, dictionary: value)
            } else {
                throw encodingError(forValue: value, codingPath: container.codingPath)
            }
        }
    }

    static func encode(to container: inout KeyedEncodingContainer<JSONCodingKey>, dictionary: [String: Any]) throws {
        for (key, value) in dictionary {
            let key = JSONCodingKey(stringValue: key)!
            if let value = value as? Bool {
                try container.encode(value, forKey: key)
            } else if let value = value as? Int64 {
                try container.encode(value, forKey: key)
            } else if let value = value as? Double {
                try container.encode(value, forKey: key)
            } else if let value = value as? String {
                try container.encode(value, forKey: key)
            } else if value is JSONNull {
                try container.encodeNil(forKey: key)
            } else if let value = value as? [Any] {
                var container = container.nestedUnkeyedContainer(forKey: key)
                try encode(to: &container, array: value)
            } else if let value = value as? [String: Any] {
                var container = container.nestedContainer(keyedBy: JSONCodingKey.self, forKey: key)
                try encode(to: &container, dictionary: value)
            } else {
                throw encodingError(forValue: value, codingPath: container.codingPath)
            }
        }
    }

    static func encode(to container: inout SingleValueEncodingContainer, value: Any) throws {
        if let value = value as? Bool {
            try container.encode(value)
        } else if let value = value as? Int64 {
            try container.encode(value)
        } else if let value = value as? Double {
            try container.encode(value)
        } else if let value = value as? String {
            try container.encode(value)
        } else if value is JSONNull {
            try container.encodeNil()
        } else {
            throw encodingError(forValue: value, codingPath: container.codingPath)
        }
    }

    public required init(from decoder: Decoder) throws {
        if var arrayContainer = try? decoder.unkeyedContainer() {
            self.value = try JSONAny.decodeArray(from: &arrayContainer)
        } else if var container = try? decoder.container(keyedBy: JSONCodingKey.self) {
            self.value = try JSONAny.decodeDictionary(from: &container)
        } else {
            let container = try decoder.singleValueContainer()
            self.value = try JSONAny.decode(from: container)
        }
    }

    public func encode(to encoder: Encoder) throws {
        if let arr = self.value as? [Any] {
            var container = encoder.unkeyedContainer()
            try JSONAny.encode(to: &container, array: arr)
        } else if let dict = self.value as? [String: Any] {
            var container = encoder.container(keyedBy: JSONCodingKey.self)
            try JSONAny.encode(to: &container, dictionary: dict)
        } else {
            var container = encoder.singleValueContainer()
            try JSONAny.encode(to: &container, value: self.value)
        }
    }
}
