//
//  TodoTableTableViewController.swift
//  SeSAC_Week3
//
//  Created by hoon on 2023/07/27.
//

import UIKit

class TodoTableTableViewController: UITableViewController {

    var list = ["장보기", "영화보기", "잠자기", "코드보기" ,"과제하기", "복습하기", "쉬기", "쉬기", "쉬자"]
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    @IBAction func addButtonClicked(_ sender: UIBarButtonItem) {
        
        showAlert(title: "알림")
        
        //1.list에 요소 추가
        list.append("고래밥 먹기")
        print(list)
        //2. ⭐️테이블뷰 갱신(동기화 작업), 밑의 함수를 다시 한번씩 호출해도 되지만 이 함수를 쓰면 편하다.
        tableView.reloadData()
    }
    
    
    
    //1. 섹션 내 셀의 갯수 : 카톡 치누 수만큼 셀 갯수가 필요해 라고 iOS에게 전달
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return list.count
        
    }
    
    //2. 셀 디자인 및 데이터 처리 : 카톡 프로필 모서리 둥글게, 프로필 이미지와 상태 메시지 반영
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        print(#function, indexPath)
        //Identifier는 인터페이스 빌더에서 설정! , 재사용 메커니즘
        let cell = tableView.dequeueReusableCell(withIdentifier: "settingCell")!
        
        
        //삼항연산자를 활용하여 색을 번갈아가면서 넣어주기
        cell.backgroundColor = indexPath.row % 2 == 0 ? .lightGray : .white
        
        
        //MARK: - 조건문대신에 코드1줄로
//        if indexPath.row == 0 {
//            cell.textLabel?.text = list[indexPath.row]
//        } else if indexPath.row == 1 {
//            cell.textLabel?.text = list[indexPath.row]
//        } else if indexPath.row == 2 {
//            cell.textLabel?.text = list[indexPath.row]
//        } else {
//            cell.textLabel?.text = list[indexPath.row]
//        }
        
        
    
        
        cell.textLabel?.text = list[indexPath.row]
        //MARK: -
        
        //extension
        cell.textLabel?.configureTitleText()
        
        
        cell.detailTextLabel?.text = "디테일 텍스트"
        cell.detailTextLabel?.textColor = .blue
        cell.detailTextLabel?.font = .systemFont(ofSize: 15)
        
        cell.imageView?.image = UIImage(systemName: "star.fill")
        
        return cell
    }
    
    //3. 셀의 높이 : 지정하지 않으면 default 44, 카카오톡이라면 대략 60~70
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 70
    }
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    

}
