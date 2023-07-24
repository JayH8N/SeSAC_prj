//
//  ViewController.swift
//  SearchNewWord
//
//  Created by hoon on 2023/07/21.
//

import UIKit







class SearchWordController: UIViewController {
    
    var keyword: [String:String] = ["ㅇㅇ": "응응", "ㅋㅋ": "킥킥", "ㅎㅎ": "히히", "ㄱㅅ": "감사", "ㄷㄷ": "덜덜", "ㄱㄱ": "고고", "ㅎㄱ": "허걱", "ㄴㄴ": "노노", "ㅇㄷ": "어디"]
    
    
    
    
    @IBOutlet var searchWindow: UITextField!
    @IBOutlet var searchButton: UIButton!
    
    @IBOutlet var resultBackground: UIImageView!
    
    @IBOutlet var shortKeyword: [UIButton]!
    
    @IBOutlet var resultLabel: UILabel!
    var keys: [String] = []
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        for i in keyword.keys {
            keys.append(i)
        }
        
        designTextField(name: searchWindow)
        designSearchButton(name: searchButton)
        designResultLabel(name: resultBackground, imageName: "background")
        designShortKeyword(name: shortKeyword)
        resultLabel.text = "줄임말 검색기입니다."
        resultLabel.numberOfLines = 0
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
            button.setTitle(keys.randomElement()!, for: .normal)
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
        guard let text = searchWindow.text, text.count > 1 else {
            let alert = UIAlertController(title: "잘못된 입력입니다.", message: "", preferredStyle: .alert)
            let cancel = UIAlertAction(title: "취소", style: .cancel)
            let ok = UIAlertAction(title: "확인", style: .default)
            
            alert.addAction(cancel)
            alert.addAction(ok)
            
            present(alert, animated: true)
            return }
        
        resultLabel.text = keyword[text]
        searchWindow.text = ""
    }
    
    
    
    //탭제스쳐 함수
    @IBAction func tapGesture(_ sender: UITapGestureRecognizer) {
        view.endEditing(true)
    }
    
}
