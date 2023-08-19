//
//  ViewController.swift
//  Media
//
//  Created by hoon on 2023/08/19.
//

import UIKit

class MainViewController: UIViewController {
    
    
    @IBOutlet var searchBar: UISearchBar!
    @IBOutlet var tableView: UITableView!
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //tableView
        tableViewDelegate()
        registerNib()
        
        //searchBar
        settingButton()
        searchBar.delegate = self
        searchBar.isHidden = true
        
        
    }
    
    
    
    


}
