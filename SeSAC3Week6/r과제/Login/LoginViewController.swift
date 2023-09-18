//
//  JackFlixViewController.swift
//  SeSAC3Week6
//
//  Created by hoon on 2023/08/24.
//

import UIKit
import SnapKit

class LoginViewController: UIViewController {
    
    let viewModel = LoginViewModel()

    let titleLabel = {
        let label = UILabel()
        label.text = "NETFLIX"
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
        label.isSecureTextEntry = true
        
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
    
    let realTimeLabel = {
        let view = UILabel()
        view.layer.borderColor = UIColor.systemPink.cgColor
        view.layer.borderWidth = 3
        view.backgroundColor = .white
        view.textAlignment = .center
        return view
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
        
        setBind()
        setAddTarget()
    }
    
    private func setAddTarget() {
        email.addTarget(self, action: #selector(emailFieldChanged), for: .editingChanged)
        password.addTarget(self, action: #selector(passwordFieldChanged), for: .editingChanged)
        nickName.addTarget(self, action: #selector(nickNameFieldChanged), for: .editingChanged)
        location.addTarget(self, action: #selector(locationFieldChanged), for: .editingChanged)
        recommendCode.addTarget(self, action: #selector(recommendCodeFieldChanged), for: .editingChanged)
    }
    
    
    @objc func emailFieldChanged() {
        viewModel.email.value = email.text!
        viewModel.checkValidation()
    }
    
    @objc func passwordFieldChanged() {
        viewModel.pw.value = password.text!
        viewModel.checkValidation()
    }
    
    @objc func nickNameFieldChanged() {
        viewModel.nickName.value = nickName.text!
        viewModel.checkValidation()
    }
    
    @objc func locationFieldChanged() {
        viewModel.location.value = location.text!
        viewModel.checkValidation()
    }
    
    @objc func recommendCodeFieldChanged() {
        viewModel.recommendCode.value = recommendCode.text!
        viewModel.checkValidation()
    }
    
    
    private func setBind() {
        
        viewModel.email.bind { [weak self] text in
            self?.email.text = text
        }

        viewModel.pw.bind { [weak self] text in
            self?.password.text = text
        }

        viewModel.nickName.bind { [weak self] text in
            self?.nickName.text = text
        }

        viewModel.location.bind { [weak self] text in
            self?.location.text = text
        }

        viewModel.recommendCode.bind { [weak self] text in
            self?.recommendCode.text = text
        }

        viewModel.isvalid.bind { [weak self] bool in
            self?.signUpButton.isEnabled = bool
            self?.signUpButton.backgroundColor = bool ? .white : .black
            self?.realTimeLabel.text = bool ? "조건을 충족했습니다" : "조건을 충족하지 않았습니다"
        }
        
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
        view.addSubview(realTimeLabel)
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
        
        realTimeLabel.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview().inset(30)
            $0.height.equalTo(40)
            $0.bottom.equalTo(view.snp.bottom).inset(70)
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


