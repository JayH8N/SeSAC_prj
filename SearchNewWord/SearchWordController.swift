//
//  ViewController.swift
//  SearchNewWord
//
//  Created by hoon on 2023/07/21.
//

import UIKit







class SearchWordController: UIViewController {
    
    @IBOutlet var searchWindow: UITextField!
    @IBOutlet var searchButton: UIButton!
    
    @IBOutlet var resultBackground: UIImageView!
    
    @IBOutlet var shortKeyword: [UIButton]!
    
    @IBOutlet var resultLabel: UILabel!
    
    
    var keyword = ["ㅇㅇ", "ㅋㅋ", "ㅎㅎ", "ㄱㅅ", "ㄷㄷ", "ㄱㄱ", "ㅎㄱ", "ㄴㄴ", "ㅇㄷ"]
    
    
    
    //viewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        designTextField(name: searchWindow)
        designSearchButton(name: searchButton)
        designResultLabel(name: resultBackground, imageName: "background")
        designShortKeyword(name: shortKeyword)
        resultLabel.text = "줄임말 검색기입니다."
        resultLabel.numberOfLines = 0
    }
    
    //shorKeyword를 return값으로 받는 함수
    func provideShortKeyword() -> String {
        let pickword = keyword.randomElement()!
        return pickword
    }
    
    
    func designTextField(name: UITextField) {
        name.layer.borderWidth = 5
        name.layer.borderColor = UIColor.black.cgColor
        name.layer.cornerRadius = 4
        name.tintColor = .systemPink
        name.keyboardType = .emailAddress
        name.placeholder = "키워드를 입력해주세요"
        name.textColor = .black
    }
    
    
    
    func designSearchButton(name: UIButton) {
        var button = UIButton.Configuration.filled()
        button.image = UIImage(systemName: "magnifyingglass")
        button.baseBackgroundColor = .black
        button.titleAlignment = .center
        button.buttonSize = .large
        name.configuration = button
    }
    
    func designResultLabel(name: UIImageView, imageName: String) {
        name.image = UIImage(named: imageName)
        name.contentMode = .scaleAspectFill
        
    }
    
    
    func designShortKeyword(name: [UIButton]) {
        for button in name {
            button.layer.cornerRadius = 11
            button.layer.borderColor = UIColor.black.cgColor
            button.layer.borderWidth = 2
            button.setTitle(provideShortKeyword(), for: .normal)
            button.setTitleColor(.systemRed, for: .normal)
            button.tintColor = .blue
        }
    }
    
    
    //키워드 버튼을 누르면 키워드의 텍스트가 textfield에 나타나는 함수
    @IBAction func wordButtonTabed(_ sender: UIButton) {
        searchWindow.text = sender.titleLabel?.text
    }
    
    
    
    @IBAction func searchButtonPushed(_ sender: UIButton) {
        textFieldKeyboardTapped(sender)
        view.endEditing(true)
    }
    
    
    //returnkey를 누르면 resultLabel에 뜨도록 하는 함수
    @IBAction func textFieldKeyboardTapped(_ sender: Any) {
        switch searchWindow.text {
        case "ㅇㅇ" :
            resultLabel.text = "응응"
        case "ㅋㅋ" :
            resultLabel.text = "킥킥"
        case "ㅎㅎ" :
            resultLabel.text = "히히"
        case "ㄱㅅ" :
            resultLabel.text = "감사"
        case "ㄷㄷ" :
            resultLabel.text = "덜덜"
        case "ㄱㄱ" :
            resultLabel.text = "고고"
        case "ㅎㄱ" :
            resultLabel.text = "허걱"
        case "ㄴㄴ" :
            resultLabel.text = "노노"
        case "ㅇㄷ" :
            resultLabel.text = "어디"
        default:
            resultLabel.text = "찾는 결과가 없습니다."
        }
    }
    
    
    
    //탭제스쳐 함수
    @IBAction func tapGesture(_ sender: UITapGestureRecognizer) {
        view.endEditing(true)
    }
    
}
