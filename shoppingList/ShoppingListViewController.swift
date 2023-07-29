//
//  ShoppingListViewController.swift
//  shoppingList
//
//  Created by hoon on 2023/07/28.
//

import UIKit

class ShoppingListViewController: UITableViewController {
    
    
    let item = ItemListInformation()
    
    
    @IBOutlet var addView: UIView!
    @IBOutlet var addTextField: UITextField!
    @IBOutlet var addButton: UIButton!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addView.configureUIView(corner: 15, color: .systemGray5)
        addTextField.configureUITextField(plalceholder: "무엇을 구매하실 건가요?")
        addButton.confirgureUIButton(title: "추가", color: .lightGray, corner: 15)
        
        tableView.rowHeight = 70
    }
    
    func addContent() {
        guard let text = addTextField.text, text.count > 0 else { return
            showAlert(title: "잘못된 입력입니다.")
        }
        
        tableView.reloadData()
        addTextField.text = ""
    }
    
    
    @IBAction func returnKeyTapped(_ sender: UITextField) {
        addContent()
    }
    
    @IBAction func addButtonPushed(_ sender: UIButton) {
        addContent()
        view.endEditing(true)
    }
    
    //셀 갯수
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return item.list.count
        
    }
    
    
    //셀 데이터 및 디자인 처리
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "ShoppingList") as! ShoppingList
        
        let row = item.list[indexPath.row]
        
        cell.configureCell(row: row)
        
        
        
        
        return cell
    }
    
    
    
    
    
    
    
    
    
}
