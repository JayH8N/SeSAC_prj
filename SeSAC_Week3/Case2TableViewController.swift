//
//  Case2TableViewController.swift
//  SeSAC_Week3
//
//  Created by hoon on 2023/07/27.
//

import UIKit

class Case2TableViewController: UITableViewController {
    
    var section1 = ["공지사항", "실험실", "버전정보"]
    var section2 = ["개인/보안", "알림", "채팅", "멀티프로필"]
    var section3 = ["고객센터/도움말"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    //섹션 수
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 3
    }
    
    //0. 섹션 제목
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        
        if section == 0 {
            return "전체설정"
        } else if section == 1 {
            return "개인설정"
        } else {
            return "기타"
        }
    }
    
    //1. 셀 객수(필수)
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if section == 0 {
            return section1.count
        } else if section == 1 {
            return section2.count
        } else {
            return section3.count
        }
    }
    
    //2. 셀 데이터 및 디자인 처리 (필수)
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        
        //identifier에 맞는 셀이 있을 수 있기 때문에 옵셔널로 반환을 해줌 > 해제가 필요하다., 하지 않는다면 cell변수 뒤마다 ?가 붙는다.
        let cell = tableView.dequeueReusableCell(withIdentifier: "case2")!
        
        if indexPath.section == 0 {
            cell.textLabel?.text = section1[indexPath.row]
        } else if indexPath.section == 1{
            cell.textLabel?.text = section2[indexPath.row]
        } else {
            cell.textLabel?.text = section3[indexPath.row]
        }
        
        return cell
    }
    
}
