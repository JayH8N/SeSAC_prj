//
//  DetailView.swift
//  BookWorm
//
//  Created by hoon on 2023/09/05.
//

import UIKit

class DetailView: BaseView {
    
    let image = {
        let view = UIImageView()
        view.contentMode = .scaleAspectFit
        return view
    }()
    
    
    let titleLabel = {
        let view = UILabel()
        view.font = .boldSystemFont(ofSize: 25)
        view.textAlignment = .center
//        view.layer.addBorder([.bottom], width: 3, color: UIColor.black.cgColor)
        
//        view.layer.borderColor = UIColor.black.cgColor
//        view.layer.borderWidth = 2
        return view
    }()
    
    let textView = {
        let view = UITextView()
        view.layer.cornerRadius = 10
        view.layer.borderColor = UIColor.black.cgColor
        view.layer.borderWidth = 3
        view.font = .systemFont(ofSize: 25)
        return view
    }()
    
    
    let saveButtonImage = {
        let view = SaveButtonCustom(frame: .zero)
        view.image = UIImage(systemName: "checkmark.circle")
        return view
    }()
    
    override func configureView() {
        [image, titleLabel, textView, saveButtonImage].forEach {
            addSubview($0)
        }

    }
    
    
    override func setConstraints() {
        image.snp.makeConstraints { make in
            make.top.equalTo(self.safeAreaLayoutGuide)
            make.height.equalTo(self.snp.height).multipliedBy(0.3)
            make.width.equalTo(image.snp.height).multipliedBy(0.5)
            make.centerX.equalToSuperview()
        }
        
        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(image.snp.bottom).offset(10)
            make.leading.trailing.equalToSuperview().inset(20)
        }
        
        textView.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(10)
            make.leading.trailing.equalToSuperview().inset(20)
            make.bottom.equalTo(self.safeAreaLayoutGuide)
        }
        
        saveButtonImage.snp.makeConstraints { make in
            make.size.equalTo(50)
            make.bottom.equalTo(image.snp.bottom)
            make.leading.equalTo(titleLabel.snp.leading)
            
        }
    }
    
    
    
}
