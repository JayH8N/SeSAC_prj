//
//  BookDetailViewController.swift
//  BOOKWARM
//
//  Created by hoon on 2023/08/02.
//

import UIKit

class BookDetailViewController: UIViewController {
    
    static let identifier = "BookDetailViewController"
    
    @IBOutlet var bookCover: UIImageView!
    @IBOutlet var author: UILabel!
     
    var cover: String = ""
    var writer: String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        bookCover.image = UIImage(named: cover)
        author.text = writer
        
        let xmark = UIImage(systemName: "xmark")
        navigationItem.leftBarButtonItem = UIBarButtonItem.init(image: xmark, style: .plain, target: self, action: #selector(closeButtonClicked))
        navigationItem.leftBarButtonItem?.tintColor = .red
        
        
    }
    
    
    @objc
    func closeButtonClicked(_ sender: UIBarButtonItem) {
        
        dismiss(animated: true)
        
    }
    
}
