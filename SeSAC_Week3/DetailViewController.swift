//
//  DetailViewController.swift
//  SeSAC_Week3
//
//  Created by hoon on 2023/08/02.
//

import UIKit

class DetailViewController: UIViewController {
    
    var data: ToDo?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        guard let data else { return }
        print(data)
    }
    

    
    
    
    
    
}
