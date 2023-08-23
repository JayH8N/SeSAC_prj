//
//  ViewController.swift
//  SeSAC3Week6
//
//  Created by hoon on 2023/08/21.
//

import UIKit
//스토리보드
//1. 객체 얹이고, 레이아웃 잡고, 아웃렛 연결, 속성 조절

//코드베이스
//1. 뷰객체 프로퍼티 선언(클래스 인스턴스 생성)
//2. 명시적으로 루트뷰에 추가 (+ translatesAutoresizingMaskIntoConstraints)
//3. 크기와 위치 정의
//4. 속성 정의
//=> Frame 한계 (아이폰 종류가 많아짐) => AutoLayout, AutoresizingMask -> 이걸 스토리보드로 대응해왔음
//==> NSLayoutConstraints => 코드베이스 대응
    //1. isActive
    //2. addConstraints
//==> NSLayoutAnchor

class ViewController: UIViewController {
    
    //1단계
    let emailTextFeild = UITextField()
    let passwordTextField = UITextField()
    let signButton = UIButton()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //2단계
        view.addSubview(emailTextFeild)
        
        //3단계
        emailTextFeild.frame = CGRect(x: 50, y: 80, width: UIScreen.main.bounds.width - 100, height: 50)
        
        
        //4단계
        emailTextFeild.backgroundColor = .lightGray
        emailTextFeild.isSecureTextEntry = true
        emailTextFeild.keyboardType = .numberPad
        emailTextFeild.placeholder = "닉네임을 입력해주세요"
        
        //-----
        
        view.addSubview(passwordTextField)
        passwordTextField.translatesAutoresizingMaskIntoConstraints = false
        
        //MARK: - NSLayoutConstraints : isActive방식
//        NSLayoutConstraint(item: passwordTextField, attribute: .leading, relatedBy: .equal, toItem: view.safeAreaLayoutGuide, attribute: .leading, multiplier: 1, constant: 50).isActive = true //레이아웃 활성화
//
//
//        NSLayoutConstraint(item: passwordTextField, attribute: .trailing, relatedBy: .equal, toItem: view.safeAreaLayoutGuide, attribute: .trailing, multiplier: 1, constant: -50).isActive = true
//
//        NSLayoutConstraint(item: passwordTextField, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .height, multiplier: 1, constant: 60).isActive = true
//
//        NSLayoutConstraint(item: passwordTextField, attribute: .top, relatedBy: .equal, toItem: emailTextFeild, attribute: .bottom, multiplier: 1, constant: 50).isActive = true
        
        
        //MARK: - NSLayoutConstraints : addConstraints방식
        let leading = NSLayoutConstraint(item: passwordTextField, attribute: .leading, relatedBy: .equal, toItem: view.safeAreaLayoutGuide, attribute: .leading, multiplier: 1, constant: 50)
        
        let trailing = NSLayoutConstraint(item: passwordTextField, attribute: .trailing, relatedBy: .equal, toItem: view.safeAreaLayoutGuide, attribute: .trailing, multiplier: 1, constant: -50)
        
        let height = NSLayoutConstraint(item: passwordTextField, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .height, multiplier: 1, constant: 60)
        
        let top = NSLayoutConstraint(item: passwordTextField, attribute: .top, relatedBy: .equal, toItem: emailTextFeild, attribute: .bottom, multiplier: 1, constant: 50)
        
        
        view.addConstraints([leading, trailing, height, top]) //4가지 요소 추가라 배열형식인 addConstraints프로퍼티 사용
        
        passwordTextField.backgroundColor = .brown
        
        
        //MARK: - UIButton(NSLayoutAnchor)
        setLayoutAnchor()
    }
    
    
    
    
    func setLayoutAnchor() {
        view.addSubview(signButton)
        signButton.translatesAutoresizingMaskIntoConstraints = false
        
        signButton.backgroundColor = .blue
        
        NSLayoutConstraint.activate([
            //x축 중앙 - view의 중앙
            signButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            signButton.widthAnchor.constraint(equalToConstant: 300),
            
            signButton.heightAnchor.constraint(equalToConstant: 50),
            
            signButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor) //--> view.bottemAnchor는 SafeArea를 무시하고 제일 밑에 고정시킨다.
        ])
        
        
        //화면전환
        signButton.addTarget(self, action: #selector(signButtonClicked), for: .touchUpInside)
    }
    
    @objc
    func signButtonClicked() {
        //❗️스토리 보드가 없기에 의미없는 코드
//        let sb = UIStoryboard(name: <#T##String#>, bundle: <#T##Bundle?#>)
//        let vc = sb.instantiateViewController(withIdentifier: <#T##String#>) as!
//        present(vc, animated: true)
        
        
        //
        let vc = LocationViewController() //화면전환할 Class 인스턴스 생성
        let nav = UINavigationController(rootViewController: vc)
        present(nav, animated: true)
        
    }
    
    
    
    


}

