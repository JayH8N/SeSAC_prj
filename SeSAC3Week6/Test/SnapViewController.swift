//
//  SnapViewController.swift
//  SeSAC3Week6
//
//  Created by hoon on 2023/08/22.
//

import UIKit
import SnapKit

/*
 addSubView에 대한 위치
 superView
 offSet, inset
 RTL : leading vs left
 */

class SnapViewController: UIViewController {
    
    //1.
    let redView = UIView()
    let whiteView = UIView()
    let blueView = UIView()
    let yellowView = UIView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        view.backgroundColor = .lightGray
        
        //2.
        view.addSubview(redView)
        view.addSubview(whiteView)
        view.addSubview(blueView)
        blueView.addSubview(yellowView)
        
        
        //3.
        redView.backgroundColor = .red
        redView.snp.makeConstraints { make in
            make.width.equalTo(200)
            make.height.equalTo(150)
            make.centerX.equalTo(view)
            make.bottom.equalTo(view.safeAreaLayoutGuide)
        }
        
        whiteView.backgroundColor = .white
        whiteView.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide)
            make.horizontalEdges.equalTo(view.safeAreaLayoutGuide)
            make.height.equalTo(200)
        }
        
        blueView.backgroundColor = .blue
        blueView.snp.makeConstraints { make in
            make.center.equalTo(view)
            make.size.equalTo(200)
        }
        
        yellowView.backgroundColor = .yellow
        yellowView.snp.makeConstraints { make in
            make.size.equalTo(150)
            //make.size.equalToSuperview()
            make.leading.top.equalToSuperview().offset(50)
            
            //superView와 subView를 동일한 크기로 맞추고 싶을 때
            //make.edges.equalToSuperview() //= make.edges.equalTo(blueView) //= make.leading.top.trailing.bottom.equalToSuperview()
            
            //inset, offset 비교
            //make.edges.equalTo(blueView).inset(50)
            //make.edges.equalTo(blueView).offset(50)
        }
        
    }
    
    


}
