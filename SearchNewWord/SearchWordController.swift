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
    
    
    var means = ["갑자기 분위기 싸해짐", "혼자 코인 노래방에 가다", "퇴사를 준비하는 사람", "일과 삶의 균형", "Too Much Informatioin"]
    var keyList = Words.allCases.map({ "\($0)"})
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
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
        
        for i in 0...shortKeyword.count - 1 {
            shortKeyword[i].layer.cornerRadius = 11
            shortKeyword[i].layer.borderColor = UIColor.black.cgColor
            shortKeyword[i].layer.borderWidth = 2
            shortKeyword[i].setTitle(keyList[i], for: .normal)
            shortKeyword[i].setTitleColor(.systemRed, for: .normal)
            shortKeyword[i].tintColor = .blue
        }
    }
    
    func alert(title: String, message: String = "") {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let ok = UIAlertAction(title: "확인", style: .destructive)
        
        alert.addAction(ok)
        
        present(alert, animated: true)
    }

    @IBAction func wordButtonTabed(_ sender: UIButton) {
        searchWindow.text = keyList[sender.tag]
        // ???: searchWindow.text = String(keyword[sender.tag])
    }
    
    
    
    @IBAction func searchButtonPushed(_ sender: UIButton) {
        textFieldKeyboardTapped(sender)
        view.endEditing(true)
    }
    
    
    //returnkey를 누르면 resultLabel에 뜨도록 하는 함수
    @IBAction func textFieldKeyboardTapped(_ sender: Any) {
        guard let text = searchWindow.text, text.count > 1 else {
            alert(title: "잘못된 입력입니다.")
            
            return }
        
        var key: Words = .갑분싸
        
        switch text {
        case "갑분싸":
            key = .갑분싸
        case "혼코노":
            key = .워라밸
        case "퇴준생":
            key = .퇴준생
        case "워라밸":
            key = .워라밸
        case "TMI":
            key = .TMI
        default:
            alert(title: "데이터에 존재하지 않습니다.")
            
        }

        resultLabel.text = means[key.rawValue]
        searchWindow.text = ""
    }
    
    
    
    //탭제스쳐 함수
    @IBAction func tapGesture(_ sender: UITapGestureRecognizer) {
        view.endEditing(true)
    }
    
}
