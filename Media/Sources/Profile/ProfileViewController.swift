//
//  ProfileViewController.swift
//  Media
//
//  Created by hoon on 2023/08/29.
//

import UIKit


class ProfileViewController: BaseViewController {
    

    let mainView = ProfileView()
    
    
    lazy var rightBarItem = {
        let button = UIBarButtonItem(title: "완료", style: .plain, target: self, action: #selector(rightBarItemClicked))
        button.tintColor = .blue
        return button
    }()
    
    lazy var leftBarItem = {
        let button = UIBarButtonItem(title: "취소", style: .plain, target: self, action: #selector(leftBarItemClicked))
        button.tintColor = .blue
        return button
    }()
    
    override func loadView() {
        self.view = mainView
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "프로필 편집"
        NotificationCenter.default.addObserver(self, selector: #selector(selectPickerView), name: Notification.Name("PickerView"), object: nil)
    }
    
    @objc func selectPickerView(notification: NSNotification) {
        if let gender = notification.userInfo?["gender"] as? String {
            print("최종값전달", gender)
            mainView.genderButton.setTitle(gender, for: .normal)
        }
    }
    
    
    override func configureView() {
        super.configureView()
        navigationItem.rightBarButtonItem = rightBarItem
        navigationItem.leftBarButtonItem = leftBarItem
        
        //UIImagePicker
        guard UIImagePickerController.isSourceTypeAvailable(.camera) else {
            return
        }
        
        mainView.picker.delegate = self
        mainView.picker.sourceType = .photoLibrary
        mainView.picker.allowsEditing = true
        
        //
        mainView.imageChangeButton.addTarget(self, action: #selector(imageChangeButtonClicked), for: .touchUpInside)
        mainView.nameTitleButton.addTarget(self, action: #selector(nameTitlebuttonClicked), for: .touchUpInside)
        mainView.userNameButton.addTarget(self, action: #selector(userNameButtonClicked), for: .touchUpInside)
        mainView.genderPronounButton.addTarget(self, action: #selector(genderPronounButtonClicked), for: .touchUpInside)
        mainView.infoButton.addTarget(self, action: #selector(infoButtonClicked), for: .touchUpInside)
        mainView.linkButton.addTarget(self, action: #selector(linkButtonClicked), for: .touchUpInside)
        mainView.genderButton.addTarget(self, action: #selector(genderButtonClicked), for: .touchUpInside)
        
        
                
    }
    
    
    override func setConstraints() {
        super.setConstraints()
        
    }
    
    
    @objc func rightBarItemClicked() {
        
    }
    
    @objc func leftBarItemClicked() {
        
    }
    
    @objc func imageChangeButtonClicked() {
        present(mainView.picker, animated: true)
    }
    
    //
    @objc func nameTitlebuttonClicked() {
        let vc = NameViewController()
        vc.completionHandler = {
            self.mainView.nameTitleButton.setTitle($0, for: .normal)
        }
        
        navigationController?.pushViewController(vc, animated: true)
    }
    
    @objc func userNameButtonClicked() {
        let vc = UserNameViewController()
        vc.completionHandler = {
            self.mainView.userNameButton.setTitle($0, for: .normal)
        }
        
        navigationController?.pushViewController(vc, animated: true)
    }
    
    @objc func genderPronounButtonClicked() {
        let vc = GenderPronounViewController()
        vc.completionHandler = {
            self.mainView.genderPronounButton.setTitle($0, for: .normal)
        }
        navigationController?.pushViewController(vc, animated: true)
    }
    
    @objc func infoButtonClicked() {
        let vc = InfoViewController()
        vc.completionHandler = {
            self.mainView.infoButton.setTitle($0, for: .normal)
        }
        
        navigationController?.pushViewController(vc, animated: true)
    }
    
    @objc func linkButtonClicked() {
        let vc = LinkViewController()
        vc.completionHandler = {
            self.mainView.linkButton.setTitle($0, for: .normal)
        }
        navigationController?.pushViewController(vc, animated: true)
    }
    
    @objc func genderButtonClicked() {
        let vc = GenderViewController()
        
//        vc.completionHandler = {
//            print("성별", $0)
//            self.mainView.genderButton.setTitle($0, for: .normal)
//        }
        
        vc.modalPresentationStyle = .fullScreen
        present(vc, animated: true)
    }
    

}

extension ProfileViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    
    //취소버튼 클릭시
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true)
        print("취소\(#function)")
       
    }
    
    
    //사진을 선택하거나 카메라 촬영 직후 호출
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let image = info[UIImagePickerController.InfoKey.editedImage/*originalImage*/] as? UIImage { //picker.allowsEditing = true을 이용하여 편집된 이미지를 넣고 싶은 경우 InfoKey.editedImage로 바꿔준다.
            self.mainView.photoCircle.image = image
            dismiss(animated: true)
        }
    }
    
    
}

