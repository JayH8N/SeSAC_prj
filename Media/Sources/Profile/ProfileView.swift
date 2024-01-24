//
//  ProfileView.swift
//  Media
//
//  Created by hoon on 2023/08/29.
//

import UIKit



class ProfileView: BaseView {
    
    let picker = UIImagePickerController()
    
    let photoUIView = {
        let view = UIView()
        view.backgroundColor = .lightGray
        return view
    }()
    
    let photoCircle = {
        let view = UIImageView()
        view.image = UIImage(systemName: "person.crop.circle.fill")
        view.tintColor = .black
        return view
    }()
    
    let imageChangeButton = {
        let view = UIButton()
        view.tintColor = .blue
        view.setTitle("사진 또는 아바타 수정", for: .normal)
        view.setTitleColor(UIColor.blue, for: .normal)
        return view
    }()
    
    let nameTitle = titleLabel(text: "이름")
    let userName = titleLabel(text: "사용자 이름")
    let genderPronoun = titleLabel(text: "성별 대명사")
    let info = titleLabel(text: "소개")
    let link = titleLabel(text: "링크")
    let gender = titleLabel(text: "성별")
    
    static func titleLabel(text: String) -> UILabel {
        let label = LeadingTitle()
        label.text = text
        //label.backgroundColor = .brown
        return label
    }
    
    let nameTitleButton = buttonLabel(title: "이름")
    let userNameButton = buttonLabel(title: "사용자 이름")
    let genderPronounButton = buttonLabel(title: "성별 대명사")
    let infoButton = buttonLabel(title: "소개")
    let linkButton = buttonLabel(title: "링크")
    let genderButton = buttonLabel(title: "성별")
    
    static func buttonLabel(title: String) -> UIButton {
        let button = UIButton()
        button.setTitle(title, for: .normal)
        button.setTitleColor(UIColor.systemGray5, for: .normal)
        button.contentHorizontalAlignment = .left
        return button
    }
    
    
    
    
    //MARK: - StackView
    
    let firstStackView = stackView()
    let secondStackView = stackView()
    let thirdStackView = stackView()
    let fourthStackView = stackView()
    let fifthStackView = stackView()
    let sixthStackView = stackView()
    
    

    static func stackView() -> UIStackView {
        let view = UIStackView()
        view.axis = .horizontal
        view.alignment = .fill
        view.distribution = .fill
        view.spacing = 0
        return view
    }
    

    override func configureView() {
        addSubview(photoUIView)
        photoUIView.addSubview(photoCircle)
        photoUIView.addSubview(imageChangeButton)
        addSubview(nameTitle)
        addSubview(nameTitleButton)
        addSubview(firstStackView)
        
        addSubview(userName)
        addSubview(userNameButton)
        addSubview(secondStackView)
        
        addSubview(genderPronoun)
        addSubview(genderPronounButton)
        addSubview(thirdStackView)
        
        addSubview(info)
        addSubview(infoButton)
        addSubview(fourthStackView)
        
        addSubview(link)
        addSubview(linkButton)
        addSubview(fifthStackView)
        
        addSubview(gender)
        addSubview(genderButton)
        addSubview(sixthStackView)
        setStackView()
    }
    
    
    func setStackView() {
        
        let first  = [nameTitle, nameTitleButton]
        for i in first {
            firstStackView.addArrangedSubview(i)
        }
        
        let second  = [userName, userNameButton]
        for i in second {
            secondStackView.addArrangedSubview(i)
        }
        
        let third  = [genderPronoun, genderPronounButton]
        for i in third {
            thirdStackView.addArrangedSubview(i)
        }
        
        let fourth  = [info, infoButton]
        for i in fourth {
            fourthStackView.addArrangedSubview(i)
        }
        
        let fifth  = [link, linkButton]
        for i in fifth {
            fifthStackView.addArrangedSubview(i)
        }
        
        let sixth  = [gender, genderButton]
        for i in sixth {
            sixthStackView.addArrangedSubview(i)
        }
        
    }
        
        
    
    
    
    
    override func setConstraints() {
        photoUIView.snp.makeConstraints { make in
            make.top.leading.trailing.equalTo(self.safeAreaLayoutGuide)
            make.height.equalToSuperview().multipliedBy(0.2)
        }
        
        photoCircle.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.centerY.equalToSuperview().multipliedBy(0.8)
            make.width.equalTo(photoUIView.snp.width).multipliedBy(0.2)
            make.height.equalTo(photoCircle.snp.width).multipliedBy(1)
        }
        
        imageChangeButton.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(photoCircle.snp.bottom).offset(5)
        }
        //
        firstStackView.snp.makeConstraints { make in
            make.top.equalTo(photoUIView.snp.bottom)
            make.leading.trailing.equalTo(self).inset(10)
            make.height.equalTo(self.snp.height).multipliedBy(0.06)
        }
        
        nameTitle.snp.makeConstraints { make in
            make.width.equalTo(firstStackView.snp.width).multipliedBy(0.35)
        }
        //
        secondStackView.snp.makeConstraints { make in
            make.top.equalTo(firstStackView.snp.bottom)
            make.leading.trailing.equalTo(self).inset(10)
            make.height.equalTo(firstStackView)
        }
        
        userName.snp.makeConstraints { make in
            make.width.equalTo(secondStackView.snp.width).multipliedBy(0.35)
        }
        //
        thirdStackView.snp.makeConstraints { make in
            make.top.equalTo(secondStackView.snp.bottom)
            make.leading.trailing.equalTo(self).inset(10)
            make.height.equalTo(firstStackView)
        }
        
        genderPronoun.snp.makeConstraints { make in
            make.width.equalTo(thirdStackView.snp.width).multipliedBy(0.35)
        }
        //
        fourthStackView.snp.makeConstraints { make in
            make.top.equalTo(thirdStackView.snp.bottom)
            make.leading.trailing.equalTo(self).inset(10)
            make.height.equalTo(firstStackView)
        }
        
        info.snp.makeConstraints { make in
            make.width.equalTo(fourthStackView.snp.width).multipliedBy(0.35)
        }
        //
        fifthStackView.snp.makeConstraints { make in
            make.top.equalTo(fourthStackView.snp.bottom)
            make.leading.trailing.equalTo(self).inset(10)
            make.height.equalTo(firstStackView)
        }
        
        link.snp.makeConstraints { make in
            make.width.equalTo(fifthStackView.snp.width).multipliedBy(0.35)
        }
        //
        sixthStackView.snp.makeConstraints { make in
            make.top.equalTo(fifthStackView.snp.bottom)
            make.leading.trailing.equalTo(self).inset(10)
            make.height.equalTo(firstStackView)
        }
        
        gender.snp.makeConstraints { make in
            make.width.equalTo(sixthStackView.snp.width).multipliedBy(0.35)
        }
        
    }
}





