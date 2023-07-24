//
//  ViewController.swift
//  LEDBoard
//
//  Created by hoon on 2023/07/24.
//

import UIKit

class ViewController: UIViewController {

    
    @IBOutlet var buttons: [UIButton]!
    
    @IBOutlet var mainLabel: UILabel!
    @IBOutlet var topicUIView: UIView!
    
    @IBOutlet var textField: UITextField!
    @IBOutlet var uiView: UIView!
    
    
    var randomColor: [UIColor] = [UIColor.red, UIColor.blue, UIColor.green, UIColor.gray, UIColor.brown]
    
    var resultColor: UIColor = .black
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        topicUIView.layer.cornerRadius = 15
        designMainLabel()
        designButtons(name: buttons)
        designTextField()
        mainLabel.text = "Text"
        view.backgroundColor = UIColor.black
    }
    
    @IBAction func sendButtonPushed(_ sender: UIButton) {
    ///3)저
        ///장된 컬러값을 가진 currentTitle을 mainLabel에 띄운다.
        mainLabel.textColor = resultColor
        mainLabel.text = textField.text
        view.endEditing(true)
        textField.text = ""
    }
    
    
    //random한 UIColor값을 뽑는 함수
    func colorPicked() -> UIColor {
        let textRandomColor = randomColor[Int.random(in: 0...randomColor.count - 1)]
        return textRandomColor

    }
    
    
    //버튼을 누르면 random한 UIColor값을 변수에 저장하는 함수
    @IBAction func colorChangeButtonPushed(_ sender: UIButton) {
    ///2) 텍스트걸러 랜덤으로 변경된 값을 저장함
        resultColor = colorPicked()
        buttons[1].tintColor = resultColor
    }
    
    @IBAction func returnKeyTapped(_ sender: UITextField) {
        mainLabel.textColor = resultColor
        mainLabel.text = textField.text
    }
    
    
    @IBAction func tapGesture(_ sender: UITapGestureRecognizer) {
        uiView.isHidden.toggle()
        view.endEditing(true)
    }
    
    
    //메인레이블 디자인
    func designMainLabel() {
        mainLabel.textAlignment = .center
        mainLabel.sizeToFit()
        mainLabel.font = UIFont.boldSystemFont(ofSize: 120)
        
    }
    
    //텍스트필드 디자인
    func designTextField() {
        textField.keyboardType = .emailAddress
        textField.placeholder = "Text를 입력해주세요"
        textField.tintColor = UIColor.systemPink
        textField.layer.borderColor = UIColor.clear.cgColor
    }
    
    //보내기 버튼, 컬러버튼 디자인
    func designButtons(name: [UIButton]) {
        for i in name {
            i.layer.borderColor = UIColor.black.cgColor
            i.layer.borderWidth = 1
            i.layer.cornerRadius = 7
        }
        name[0].setTitle("보내기", for: .normal)
        name[0].setTitleColor(.black, for: .normal)
        name[1].setTitle("Aa", for: .normal)
        name[1].tintColor = .black
    }
}

