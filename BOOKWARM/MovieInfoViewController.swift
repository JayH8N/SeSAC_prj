//
//  MovieInfoViewController.swift
//  BOOKWARM
//
//  Created by hoon on 2023/07/31.
//

import UIKit

class MovieInfoViewController: UIViewController {
    

    var contents: String = "상세화면"
    
    @IBOutlet var contentsLabel: UILabel!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
//        self.title =
        
        
        
        contentsLabel.text = contents
        contentsLabel.textAlignment = .center
        contentsLabel.font = UIFont.systemFont(ofSize: 30)
    }
    


}
