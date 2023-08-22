//
//  MainViewController.swift
//  SeSAC3Week6
//
//  Created by hoon on 2023/08/22.
//

import UIKit
import SnapKit

class MainViewController: UIViewController {

    let case1Button = setUIButton()
    let case2Button = setUIButton()
    let case3Button = setUIButton()
    
    static func setUIButton() -> UIButton {
        let button = UIButton()
        button.layer.cornerRadius = 10
        button.layer.borderColor = UIColor.black.cgColor
        return button
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(case1Button)
        view.addSubview(case2Button)
        view.addSubview(case3Button)

        setCase1Button()
        setCase2Button()
        setCase3button()
        

    }
    
    func setCase1Button() {
        case1Button.backgroundColor = .systemPink
        case1Button.setTitle("Case1", for: .normal)
        case1Button.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide)
            make.leadingMargin.equalTo(20) // == make.leading.equalTo(view).inset(20)
            make.trailingMargin.equalTo(-20)
            make.height.equalTo(40)
            
        }
        case1Button.addTarget(self, action: #selector(case1ButtonClicked), for: .touchUpInside)
    }
    
    func setCase2Button() {
        case2Button.backgroundColor = .green
        case2Button.setTitle("Case2", for: .normal)
        case2Button.snp.makeConstraints { make in
            make.leadingMargin.equalTo(20)
            make.trailingMargin.equalTo(-20)
            make.height.equalTo(40)
            make.top.equalTo(case1Button.snp.bottom).offset(20)
        }
        case2Button.addTarget(self, action: #selector(case2ButtonClicked), for: .touchUpInside)
    }
    
    func setCase3button() {
        case3Button.backgroundColor = .orange
        case3Button.setTitle("Case3", for: .normal)
        case3Button.snp.makeConstraints { make in
            make.top.equalTo(case2Button.snp.bottom).offset(20)
            make.leadingMargin.equalTo(20)
            make.trailingMargin.equalTo(-20)
            make.height.equalTo(40)
        }
        case3Button.addTarget(self, action: #selector(case3ButtonClicked), for: .touchUpInside)
    }
    
    @objc
    func case1ButtonClicked() {
        
        let vc = Case1ViewController() //화면전환할 Class 인스턴스 생성
        present(vc, animated: true)
    }

    @objc func case2ButtonClicked() {
        let vc = Case2ViewController()
        
        vc.modalPresentationStyle = .fullScreen
        
        present(vc, animated: true)
    }
    
    @objc func case3ButtonClicked() {
        let vc = Case3ViewController()
        present(vc, animated: true)
    }

}
