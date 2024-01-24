//
//  FirstViewController.swift
//  Media
//
//  Created by hoon on 2023/08/25.
//

import UIKit
import SnapKit

class FirstViewController: UIViewController {
    
    let imageView = {
        let image = UIImageView()
        let url = "https://play-lh.googleusercontent.com/EUOT34urU1srqvWcf0c-f5HZe0TBOiexdtnQiNnM0lRRYIxvsRNUW7FzFGDVofvYZPoD"
        if let url = URL(string: url) {
            image.kf.setImage(with: url)
        }
        return image
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .black
        view.addSubview(imageView)
        setImageView()
    }
    
    
    func setImageView() {
        imageView.snp.makeConstraints { make in
            make.center.equalToSuperview()
            make.size.equalTo(200)
        }
    }
    
    
    
    
}
