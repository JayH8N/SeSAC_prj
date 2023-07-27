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
    @IBOutlet var searchButton: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        searchButton.setTitle("", for: .normal)
        searchButton.setImage(UIImage(systemName: "plus.square.fill.on.square.fill"), for: .normal)
        addTextField.text = ""
    }

    
    
    func addContent() {
        guard let text = addTextField.text else { return
            showAlert(title: "똑바로 입력해라")
        }
        
        list.append(text)
        tableView.reloadData()
    }
    
    
    @IBAction func keyBoardTapped(_ sender: UITextField) {
        addContent()
    }
    
    
    @IBAction func searchButtonTapped(_ sender: UIButton) {
        addContent()
    }
    
    
    
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return list.count
        
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        print(#function, indexPath)
        //Identifier는 인터페이스 빌더에서 설정! , 재사용 메커니즘
        let cell = tableView.dequeueReusableCell(withIdentifier: "case3")!
        
        cell.textLabel?.text = list[indexPath.row]
        //MARK: -
        
        //extension
        cell.textLabel?.configureTitleText()
        
        cell.imageView?.image = UIImage(systemName: "star.fill")
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }

}
