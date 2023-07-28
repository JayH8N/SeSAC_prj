//
//  CustomTableViewController.swift
//  SeSAC_Week3
//
//  Created by hoon on 2023/07/28.
//

import UIKit

class CustomTableViewController: UITableViewController {
    
    let todo = ToDoInformation()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.rowHeight = 70
    }
    
    //1.
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return todo.list.count
    }
    
    //2.
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        //(스토리보드영역) as! (로직영역) //다운캐스팅
        let cell = tableView.dequeueReusableCell(withIdentifier: CustomCell.identifier) as! CustomCell
        
        let row = todo.list[indexPath.row]
        
        
        cell.configureCell(row: row)
        
        return cell
    }
    
    
    //3.셀 선택
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print(indexPath)
    }
    
    
    
    
    
}
