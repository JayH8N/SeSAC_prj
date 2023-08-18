//
//  AsyncViewController.swift
//  SeSAC3Week4
//
//  Created by hoon on 2023/08/11.
//

import UIKit

class AsyncViewController: UIViewController {

    @IBOutlet var first: UIImageView!
    
    @IBOutlet var second: UIImageView!
    
    @IBOutlet var third: UIImageView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        first.backgroundColor = .black
        
        DispatchQueue.main.async {
            self.first.layer.cornerRadius = self.first.frame.width / 2
        }
    
    }
    
    //sync async serial concurrent
    //UI Freezing
    @IBAction func buttonClicked(_ sender: UIButton) {
        
        let url = URL(string: "https://api.nasa.gov/assets/img/general/apod.jpg")!
        
        DispatchQueue.global().async { //작업이 클때는 global().async
            let data = try! Data(contentsOf: url)
            
            DispatchQueue.main.async { //UI작업은 main.async
                //UI작업은 메인 스레드가 작업한다.
                self.first.image = UIImage(data: data)
            }
        }
    }
    

}
