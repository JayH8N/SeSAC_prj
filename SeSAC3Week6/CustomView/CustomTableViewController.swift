//
//  CustomTableViewController.swift
//  SeSAC3Week6
//
//  Created by hoon on 2023/08/24.
//

import UIKit
import SnapKit

struct Sample {
    let text: String
    var isExpand: Bool
}

class CustomTableViewController: UIViewController {
    
    //1.테이블 뷰 생성
    lazy var tableView = {
        let view = UITableView()
        view.rowHeight = UITableView.automaticDimension
        //3.테이블 뷰 연결
        view.delegate = self
        view.dataSource = self
        
        //5.셀등록, UINib - xib사용 의미
        view.register(CustomTableViewCell.self, forCellReuseIdentifier: "customCell")
        return view
    }()
    
    let imageView = {
        let view = PosterImagerView(frame: .zero)
        return view
    }()
    
    //var isExpand = false //false => numberOflines = 2, true => numberOflines = 0
    var list: [Sample] = [Sample(text: "rrrrr", isExpand: false),
                          Sample(text: "111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111", isExpand: false),
                          Sample(text: "testtesttesttesttesttesttesttesttesttesttesttesttesttesttesttesttesttesttesttesttesttesttesttesttest", isExpand: false),
                          Sample(text: "testtesttesttesttesttesttesttesttesttesttesttesttesttesttesttesttesttesttesttesttesttesttesttesttest", isExpand: false)]
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //2.
        view.backgroundColor = .white
        view.addSubview(tableView)
        tableView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        
        view.addSubview(imageView)
        imageView.snp.makeConstraints { make in
            make.size.equalTo(200)
            make.center.equalTo(view)
        }
        
        
    }
    
    
    

}

//4.
extension CustomTableViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return list.count
    }
    

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "customCell") as! CustomTableViewCell
        cell.label.text = list[indexPath.row].text
        cell.label.numberOfLines = list[indexPath.row].isExpand ? 0 : 2
        
        return cell
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        //       isExpand.toggle()
        list[indexPath.row].isExpand.toggle()
 //       tableView.reloadData()
        
        tableView.reloadRows(at: [indexPath, IndexPath(row: 2, section: 0)], with: .automatic)
        
        
    }
}
