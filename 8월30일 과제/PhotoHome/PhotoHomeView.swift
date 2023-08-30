//
//  PhotoHomeView.swift
//  Diary
//
//  Created by hoon on 2023/08/30.
//

import UIKit
import Kingfisher


class PhotoHomeView: BaseView {
    
    let mainImageView = {
        let view = UIImageView()
        view.layer.cornerRadius = 10
        view.layer.borderColor = UIColor.black.cgColor
        view.layer.borderWidth = 3
        view.contentMode = .scaleAspectFill
        view.clipsToBounds = true
        let url = "https://my-lingo.com/enko/wp-content/uploads/2022/12/I3007.png"
        
        if let url = URL(string: url) {
            view.kf.setImage(with: url)
        }
        return view
    }()
    
    let addButton = {
        let uibutton = UIButton()
        let buttonImage = UIImage.SymbolConfiguration(pointSize: 60, weight: .bold, scale: .small)
        let image = UIImage(systemName: "plus.circle", withConfiguration: buttonImage)
        uibutton.setImage(image, for: .normal)
        uibutton.tintColor = .lightGray
        return uibutton
    }()
    
    let picker = UIImagePickerController()
    
    
    override func configureView() {
        addSubview(mainImageView)
        addSubview(addButton)
    }
    
    
    override func setConstraints() {
        mainImageView.snp.makeConstraints { make in
            make.top.leading.trailing.edges.equalTo(self.safeAreaLayoutGuide).inset(10)
            make.height.equalToSuperview().multipliedBy(0.4)
        }
        
        
        addButton.snp.makeConstraints { make in
            make.top.equalTo(mainImageView.snp.bottom).offset(10)
            make.trailing.equalTo(mainImageView)
        }
    }
    
    
}
