//
//  BaeminViewController.swift
//  SearchNewWord
//
//  Created by hoon on 2023/07/22.
//

import UIKit

class BaeminViewController: UIViewController {

    
    @IBOutlet var a: [UIButton]!
    
    @IBOutlet var adImage: UIImageView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        styleOfButton(name: a)
        styleOfAdimage(name: adImage)
        // Do any additional setup after loading the view.
    }
    
    func styleOfButton(name: [UIButton]) {
        for i in name {
            i.layer.cornerRadius = 15
            i.layer.borderWidth = 2
            i.layer.borderColor = UIColor.black.cgColor
            i.clipsToBounds = true
            i.layer.shadowColor = UIColor.red.cgColor
            i.layer.shadowOffset = CGSize(width: 0, height: 0)
            i.layer.shadowRadius = 15
            i.layer.shadowOpacity = 0.5
        }
    }
    
    func styleOfAdimage(name: UIImageView) {
        name.image = UIImage(named: "banner02")
        name.layer.cornerRadius = 15
        name.layer.borderColor = UIColor.black.cgColor
        name.layer.borderWidth = 2
        name.contentMode = .scaleToFill
    }
    
    

}
