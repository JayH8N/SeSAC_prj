//
//  TVDetailViewController.swift
//  Media
//
//  Created by hoon on 2023/08/20.
//

import UIKit

class TVDetailViewController: UIViewController {

    
    
    override func viewDidLoad() {
        super.viewDidLoad()

       setXmark()
    }
    
    func setXmark() {
        let xmark = UIImage(systemName: "xmark")
        navigationItem.leftBarButtonItem = UIBarButtonItem.init(image: xmark, style: .plain, target: self, action: #selector(closeButtonClicked))
        navigationItem.leftBarButtonItem?.tintColor = .black
    }
    
    @objc
    func closeButtonClicked(_ sender: UIBarButtonItem) {
        dismiss(animated: true)
    }
    
    
    
    
    
    
    
    

  

}
