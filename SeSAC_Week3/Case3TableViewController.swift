//
//  Case3TableViewController.swift
//  SeSAC_Week3
//
//  Created by hoon on 2023/07/27.
//

import UIKit

class Case3TableViewController: UITableViewController {
    
    var list: [String] = []
    
    
    @IBOutlet var addTextField: UITextField!
    @IBOutlet var addButton: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addButton.configureStyle(title: "추가", color: .black)
        addTextField.configureStyle(text: "", placeholder: "무엇을 입력하실건가요?")
    }
    
    
    
    func addContent() {
        guard let text = addTextField.text, text.count > 1 else { return
            showAlert(title: "똑바로 입력해라")
        }
        list.append(text)
        tableView.reloadData()
    }
    
    
    @IBAction func keyBoardTapped(_ sender: UITextField) {
        addContent()
        addTextField.text = ""
    }
    
    
    @IBAction func addButtonTapped(_ sender: UIButton) {
        addContent()
        addTextField.text = ""
    }
    
    
    
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return list.count
        
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        print(#function, indexPath)
        //Identifier는 인터페이스 빌더에서 설정! , 재사용 메커니즘
        let cell = tableView.dequeueReusableCell(withIdentifier: "case3")!
        
        let ribbon = UIImage(systemName: "star")
        cell.accessoryView = UIImageView(image: ribbon)
        
        cell.textLabel?.text = list[indexPath.row]
        //MARK: -
        
        cell.textLabel?.configureTitleText()
        cell.backgroundColor = .systemGray4
        
        return cell
    }
}
