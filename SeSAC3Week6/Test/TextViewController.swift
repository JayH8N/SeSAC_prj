//
//  TextViewController.swift
//  SeSAC3Week6
//
//  Created by hoon on 2023/08/22.
//

import UIKit
import SnapKit

class TextViewController: UIViewController {

    //방법1. static함수로 변경, 방법2. lazy 이용 => 클로저 사용하면 의미없음
    let photoImageView = {
        let view = UIImageView()
        view.backgroundColor = .systemMint
        view.contentMode = .scaleAspectFill
        return view
    }()
    
    let titletextField = {
        let view = UITextField()
        view.borderStyle = .none
        view.layer.borderColor = UIColor.black.cgColor
        view.layer.borderWidth = 1
        view.placeholder = "제목을 입력해주세요"
        view.textAlignment = .center
        view.font = .boldSystemFont(ofSize: 15)
        return view
    }()
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        
        //addSubview 반복문으로 단축
        for item in [photoImageView, titletextField] {
            view.addSubview(item)
        }
        
        
        //addSubview forEach문으로 단축
        [photoImageView, titletextField].forEach {
            view.addSubview($0)
        }
        
        
        //* phtoImageView, 정적인 디자인 --> viewDidLoad에 꼭 써야될까?
        //photoImageView.backgroundColor = .systemMint
        //photoImageView.contentMode = .scaleAspectFill

        setupConstraints()
        
    }

    
    func setupConstraints() {
        photoImageView.snp.makeConstraints { make in
            make.top.leading.trailing.equalTo(view.safeAreaLayoutGuide)
            //make.height.equalTo(200)
            
            //뷰기준 30%정도 차지하려고 할 때
            make.height.equalTo(view).multipliedBy(0.3)
        }
        
        
        //???: -
        titletextField.snp.makeConstraints { make in
            make.top.equalTo(photoImageView.snp.bottom).offset(20)
            make.leadingMargin.equalTo(20) // == make.leading.equalTo(view).inset(20)
            make.trailingMargin.equalTo(-20)
            make.height.equalTo(50)
        }
        
        
        
        
    }
    
    
    



}
