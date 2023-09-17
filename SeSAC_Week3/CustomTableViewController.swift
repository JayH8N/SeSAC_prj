//
//  CustomTableViewController.swift
//  SeSAC_Week3
//
//  Created by hoon on 2023/07/28.
//
import UIKit
/*
 1. 파티를 막자
 2. sender.tag
 */


class CustomTableViewController: UITableViewController {
    
    @IBOutlet var searchBar: UISearchBar!
    
    
    var todo = ToDoInformation() {
        didSet { //변수가 달라짐을 감지!
            print("ㅎㅇ")
            tableView.reloadData()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        searchBar.placeholder = "할일을 입력해보세요"
        tableView.rowHeight = 70
        searchBar.searchTextField.addTarget(self, action: #selector(searchBarReturnTapped), for: .editingDidEndOnExit)
    }
    
    @objc func searchBarReturnTapped() {
        print("searchbar clicked")
        
        //ToDo항목을
        let data = ToDo(main: searchBar.text!, sub: "23.08.01", like: false, done: false, color: ToDoInformation.randomBackgroundColor())
        
        //list에 뒤에 추가
        //todo.list.append(data)
        //list 앞쪽에 추가
        todo.list.insert(data, at: 0)
        searchBar.text = ""
        
        //갱신
        //tableView.reloadData()
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
        cell.likeButton.tag = indexPath.row
        cell.likeButton.addTarget(self, action: #selector(likeButtonClicked), for: .touchUpInside)
        
        return cell
    }
    
    
    @objc
    func likeButtonClicked(_ sender: UIButton) {
        print("clicked \(sender.tag)")
        //indexPath에 대한 정보가 이 함수에 없다. 대신 sender에 tag에 대한 정보가 있다
        todo.list[sender.tag].like.toggle()
        
        //tableView.reloadData()
        
    }
    
    
    
    
    //3.셀 선택
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = storyboard?.instantiateViewController(withIdentifier: "DetailViewController") as! DetailViewController
        
        vc.data = todo.list[indexPath.row]
        
        present(vc, animated: true)
        
        tableView.reloadRows(at: [indexPath], with: .none)
    }
    
    

    //삭제 기능 구현
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        
        //제거 -> 갱신
        todo.list.remove(at: indexPath.row)
        
        //tableView.reloadData()
    }
    
    
    
    
}
