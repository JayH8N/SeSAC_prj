//
//  FreezerPageViewController.swift
//  Pantry
//
//  Created by hoon on 2023/10/09.
//

import UIKit

class FreezerPageViewController: BaseViewController {
    
    
    let mainView = FreezerPageView()
    
    override func loadView() {
        view = mainView
        
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    
    
    
    override func configureView() {
        mainView.introDuctionButton.addTarget(self, action: #selector(introDuctionButtonTapped), for: .touchUpInside)
    }
    
    override func setConstraints() {
        
    }
    
    @objc private func introDuctionButtonTapped() {
        let x = UIScreen.main.bounds.width / 2
        let y = UIScreen.main.bounds.height / 2
        
        mainView.makeToast(NSLocalizedString("introDes", comment: ""),
                           duration: 3.0, point: CGPoint(x: x, y: y),
                           title: NSLocalizedString("introTitle", comment: ""),
                           image: UIImage(named: "ExampleBar"),
                           style: .init(),
                           completion: nil)
    }
    
    
}
