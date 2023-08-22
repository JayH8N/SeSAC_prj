//
//  Case2ViewController.swift
//  SeSAC3Week6
//
//  Created by hoon on 2023/08/22.
//

import UIKit
import Kingfisher
import SnapKit

class Case2ViewController: UIViewController {

    let backImageView = imageView()
    
    static func imageView() -> UIImageView {
        let image = UIImageView()
        image.contentMode = .scaleToFill
        return image
    }
    
    let xmark = uiButton(imageName: "xmark")
    let firstButton = uiButton(imageName: "gift.circle")
    let secondButton = uiButton(imageName: "square.and.arrow.up.circle")
    let thirdButton = uiButton(imageName: "gearshape")
    
    static func uiButton(imageName: String) -> UIButton {
        let button = UIButton()
        button.setImage(UIImage(systemName: imageName), for: .normal)
        button.tintColor = .white
        button.contentVerticalAlignment = .fill
        button.contentHorizontalAlignment = .fill
        button.imageEdgeInsets = UIEdgeInsets(top: 2, left: 2, bottom: 2, right: 2)
        return button
    }
    
    
    let stackView = {
        let stackView = UIStackView()
        
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .horizontal
        stackView.alignment = .fill
        stackView.distribution = .fillEqually
        stackView.spacing = 4
        return stackView
    }()
    
    let profileImageView = {
       let view = UIImageView()
        view.layer.cornerRadius = 15
        view.clipsToBounds = true
        view.contentMode = .scaleToFill
        return view
    }()
    
    let profileName = {
        let nameLabel = UILabel()
        nameLabel.textColor = .white
        nameLabel.font = .systemFont(ofSize: 25)
        nameLabel.textAlignment = .center
        nameLabel.text = "Jack"
        return nameLabel
    }()
    
    let profileStackView = {
        let stackView = UIStackView()
        
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.alignment = .fill
        stackView.distribution = .equalSpacing
        stackView.spacing = 0
        return stackView
    }()
    
    
    let bottomButton1 = UIButton()
    let bottomButton2 = UIButton()
    let bottomButton3 = UIButton()
    
    let bottomStackView = {
        let stackView = UIStackView()
        
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .horizontal
        stackView.alignment = .fill
        stackView.distribution = .fillEqually//.equalCentering
        stackView.spacing = 10
        return stackView
    }()
    
    
    
    var backImageURL = "https://mblogthumb-phinf.pstatic.net/MjAxOTA3MTFfMjkz/MDAxNTYyODE4NzgyNzAz.spF-UPv2e4FUri41SGizxNMQRZb5VGbNs0H05cCWPfQg.e4yrDL47pXBmjyCfs4tRsi5mqU-ATAylfI42Wdu-RIQg.JPEG.yzzzii/output_935416776.jpg?type=w800"
    
    var profileImage = "https://cdn.pixabay.com/photo/2015/10/05/22/37/blank-profile-picture-973460_640.png"
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //-----
        view.addSubview(backImageView)
        backImageView.isUserInteractionEnabled = true
        backImageView.addSubview(xmark)
        backImageView.addSubview(firstButton)
        backImageView.addSubview(secondButton)
        backImageView.addSubview(thirdButton)
        backImageView.addSubview(stackView)
        backImageView.addSubview(profileImageView)
        backImageView.addSubview(profileName)
        backImageView.addSubview(profileStackView)
        backImageView.addSubview(bottomButton1)
        backImageView.addSubview(bottomButton2)
        backImageView.addSubview(bottomButton3)
        backImageView.addSubview(bottomStackView)
        //-----
        
        
        view.backgroundColor = .white
        setBackImageView(image: backImageView, url: backImageURL)
        
        
        
         //버튼3형제 스택뷰
        let buttons = [firstButton, secondButton, thirdButton]
        
        for button in buttons {
            stackView.addArrangedSubview(button)
        }
        
        //프로필 스택뷰
        let profiles = [profileImageView, profileName]
        
        for cp in profiles {
            profileStackView.addArrangedSubview(cp)
        }
        
        //프로필
        setProfileImageView(image: profileImageView, url: profileImage)
        setProfileLabel()
        setProfileStackView()
        
        
        //상단
        setXmark()
        setButton1()
        setButton2()
        setButton3()
        setStackView()
        
        //하단 스택뷰
        let bottomButtons = [bottomButton1, bottomButton2, bottomButton3]
        
        for button in bottomButtons {
            bottomStackView.addArrangedSubview(button)
        }
        
        //bottom
        setBottomUIButton(uiButton: bottomButton1, title: "나와의 채팅", imageName: "message.fill")
        setBottomUIButton(uiButton: bottomButton2, title: "프로필 편집", imageName: "pencil")
        setBottomUIButton(uiButton: bottomButton3, title: "카카오 스토리", imageName: "book.fill")
        setBottomStackView()
        
    }
    
    
    //MARK: - imageView
    
    func setBackImageView(image: UIImageView, url: String) {
        image.snp.makeConstraints { make in
            make.top.bottom.leading.trailing.equalTo(view)
        }
        if let url = URL(string: url) {
            image.kf.setImage(with: url)
        }
        
    }
    
    func setProfileImageView(image: UIImageView, url: String) {
        image.snp.makeConstraints { make in
            make.size.equalTo(100)
        }
        if let url = URL(string: url) {
            image.kf.setImage(with: url)
        }
    }
    
    
    //MARK: - Label
    
    func setProfileLabel() {
        profileName.snp.makeConstraints { make in
            make.height.equalTo(30)
        }
    }
    
    
    //MARK: - Xmark
    func setXmark() {
        print(#function)
        xmark.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide).inset(4)
            make.leading.equalTo(16)
            make.size.equalTo(30)
        }
        
        xmark.addTarget(self, action: #selector(Self.closeButtonClicked), for: .touchUpInside)
    }
    
    @objc
    func closeButtonClicked() {
        print("====")
        dismiss(animated: true)
    }
    
    //MARK: - 버튼3형제
    
    func setButton1() {
        firstButton.snp.makeConstraints { make in
            make.size.equalTo(40)
        }
    }
    
    func setButton2() {
        secondButton.snp.makeConstraints { make in
            make.size.equalTo(40)
        }
    }
    
    func setButton3() {
        firstButton.snp.makeConstraints { make in
            make.size.equalTo(40)
        }
    }
    
    func setStackView() {
        stackView.snp.makeConstraints { make in
            make.trailingMargin.equalTo(-20)
            make.top.equalTo(view.safeAreaLayoutGuide).inset(4)
            make.height.equalTo(40)
        }
    }
    
    //프로필 스택뷰
    func setProfileStackView() {
        profileStackView.snp.makeConstraints { make in
            make.centerX.equalTo(view)
            make.centerY.equalTo(view).multipliedBy(1.3)
        }
    }
    
    //bottom 버튼
    func setBottomUIButton(uiButton: UIButton, title: String, imageName: String) {
        
        var button = UIButton.Configuration.plain()
        
        button.title = title
        
        button.titleAlignment = .center

        //이미지 삽입
        button.image = UIImage(systemName: imageName)
        button.imagePadding = 15
        button.imagePlacement = .top

        uiButton.configuration = button
        uiButton.tintColor = .white

        
    }
    
    

    
    //bottom스택뷰
    func setBottomStackView() {
        bottomStackView.snp.makeConstraints { make in
            make.leadingMargin.equalTo(24)
            make.trailingMargin.equalTo(-24)
            make.top.equalTo(profileStackView.snp.bottom).offset(16)
            make.height.equalTo(130)
        }
    }
    
    

}
