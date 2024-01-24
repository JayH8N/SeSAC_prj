//
//  JackFlixViewController.swift
//  SeSAC3Week6
//
//  Created by hoon on 2023/08/24.
//

import UIKit
import SnapKit

class JackFlixViewController: UIViewController {

    let titleLabel = {
        let label = UILabel()
        label.text = "JACKFLIX"
        label.textColor = .red
        label.textAlignment = .center
        label.font = .boldSystemFont(ofSize: 35)
        return label
    }()
    
    let email = {
        let label = InputTextField()
        label.setupView()
        label.placeholder = "이메일 주소 또는 전화번호"
        return label
    }()
    let password = {
        let label = InputTextField()
        label.setupView()
        label.placeholder = "비밀번호"
        return label
    }()
    let nickName = {
        let label = InputTextField()
        label.setupView()
        label.placeholder = "닉네임"
        return label
    }()
    let location = {
        let label = InputTextField()
        label.setupView()
        label.placeholder = "위치"
        return label
    }()
    let recommendCode = {
        let label = InputTextField()
        label.setupView()
        label.placeholder = "추천 코드 입력"
        return label
    }()
    
    let signUpButton = {
        let button = UIButton()
        button.layer.cornerRadius = 5
        button.backgroundColor = .white
        let attribute = [NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 19)]
        let attributedTitle = NSAttributedString(string: "회원가입", attributes: attribute)
        button.setAttributedTitle(attributedTitle, for: .normal)
        return button
    }()
    
    let extraLabel = {
        let label = UILabel()
        label.text = "추가 정보 입력"
        label.font = .systemFont(ofSize: 19)
        label.textColor = .white
        label.textAlignment = .center
        return label
    }()
    
    let bottomSwitch = {
        let switchButton = UISwitch()
        switchButton.onTintColor = .red
        switchButton.isOn = true
        return switchButton
    }()
    
    
    //MARK: - StackView
    let inputLabelsStackView = {
        let stackView = UIStackView()
        
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.alignment = .fill
        stackView.distribution = .fillEqually//.equalCentering
        stackView.spacing = 20
        return stackView
    }()
    
    
    //MARK: - viewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .black
        addSubView()
        setTitleLabel()
        setInputLabelsStackView()
        setSignUpButton()
        setExtraLabel()
        setBottomSwitch()
    }
    
    //MARK: - addSubView
    
    func addSubView() {
        view.addSubview(titleLabel)
        view.addSubview(email)
        view.addSubview(password)
        view.addSubview(nickName)
        view.addSubview(location)
        view.addSubview(recommendCode)
        view.addSubview(inputLabelsStackView)
        view.addSubview(signUpButton)
        view.addSubview(extraLabel)
        view.addSubview(bottomSwitch)
    }
    
    //MARK: - titleLabel
    func setTitleLabel() {
        titleLabel.snp.makeConstraints { make in
            make.centerX.equalTo(view)
            make.top.equalTo(view.safeAreaLayoutGuide).offset(30)
            make.width.equalTo(200)
            make.height.equalTo(50)
        }
    }
    
    //MARK: - InputLabels, StackView
    
    func setInputLabelsStackView() {
        let inputLabels = [email, password, nickName, location, recommendCode]
        
        for label in inputLabels {
            inputLabelsStackView.addArrangedSubview(label)
        }
        
        inputLabelsStackView.snp.makeConstraints { make in
            make.centerX.equalTo(view)
            make.centerY.equalTo(view).multipliedBy(0.88)
            make.leading.equalTo(30)
            make.trailing.equalTo(-30)
            make.height.equalTo(280)
        }
    }
    
    //MARK: - SignUp Button
    
    func setSignUpButton() {
        signUpButton.snp.makeConstraints { make in
            make.centerX.equalTo(view)
            make.leading.equalTo(30)
            make.trailing.equalTo(-30)
            make.height.equalTo(44)
            make.top.equalTo(inputLabelsStackView.snp.bottom).offset(20)
        }
    }
    
    //MARK: - extraLabel
    
    func setExtraLabel() {
        extraLabel.snp.makeConstraints { make in
            make.top.equalTo(signUpButton.snp.bottom).offset(20)
            make.leading.equalTo(30)
        }
    }

    //MARK: - bottomSwitch
    
    func setBottomSwitch() {
        bottomSwitch.snp.makeConstraints { make in
            make.trailing.equalTo(-30)
            make.top.equalTo(signUpButton.snp.bottom).offset(20)
            
        }
    }


}


