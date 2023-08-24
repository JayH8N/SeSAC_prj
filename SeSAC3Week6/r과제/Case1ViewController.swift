//
//  Case1ViewController.swift
//  SeSAC3Week6
//
//  Created by hoon on 2023/08/22.
//

import UIKit
import SnapKit

class Case1ViewController: UIViewController {
    //🏞️1.
    let picker = UIImagePickerController()
    
    

    let imageView = UIImageView()
    
    
    let textField1 = textField(placeholder: "제목을 입력해주세요")
    let textField2 = textField(placeholder: "날짜를 입력해주세요")
    let textField3 = textField()
    
    static func textField(placeholder: String? = nil) -> UITextField {
        let textF = UITextField()
        textF.placeholder = placeholder
        textF.layer.borderWidth = 2
        textF.layer.borderColor = UIColor.black.cgColor
        textF.textAlignment = .center
        return textF
    }

    
    //MARK: - viewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        view.addSubview(imageView)
        view.addSubview(textField1)
        view.addSubview(textField2)
        view.addSubview(textField3)
        
        setImageView()
        setTextField1()
        setTextField2()
        setTextField3()
    }
    
    //MARK: - viewDidAppear
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        //🏞️2.available
        guard UIImagePickerController.isSourceTypeAvailable(.camera) else { //.photoLibrary
            print("갤러리 사용불가, 사용자에게 토스/얼럿")
            return
        }
        picker.delegate = self
        picker.sourceType = .camera//.photoLibrary
        picker.allowsEditing = true
        
        //➕💡다양한 컨트롤러
        //let picker = UIFontPickerViewController() //UIColorPickerViewController()
        
        present(picker, animated: true)
        
    }
    
    func setImageView() {
        imageView.backgroundColor = .lightGray
        imageView.snp.makeConstraints { make in
            make.top.equalTo(view)
            make.leadingMargin.equalTo(20)
            make.trailingMargin.equalTo(-20)
            make.height.equalTo(view).multipliedBy(0.35)
        }
    }
    
    func setTextField1() {
        textField1.snp.makeConstraints { make in
            make.height.equalTo(55)
            make.leadingMargin.equalTo(20)
            make.trailingMargin.equalTo(-20)
            make.top.equalTo(imageView.snp.bottom).offset(20)
        }
    }
    
    func setTextField2() {
        textField2.snp.makeConstraints { make in
            make.height.equalTo(55)
            make.leadingMargin.equalTo(20)
            make.trailingMargin.equalTo(-20)
            make.top.equalTo(textField1.snp.bottom).offset(20)
        }
    }
    
    func setTextField3() {
        textField3.snp.makeConstraints { make in
            make.leadingMargin.equalTo(20)
            make.trailingMargin.equalTo(-20)
            make.top.equalTo(textField2.snp.bottom).offset(20)
            make.bottom.equalTo(view.safeAreaLayoutGuide)
        }
    }
        
    


}



//MARK: - extension


//🏞️3.앨범상에서 puch-pop구조이기에 navigationcontroller필요함
extension Case1ViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    
    //취소버튼 클릭시
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true)
        print("취소\(#function)")
       
    }
    
    
    //사진을 선택하거나 카메라 촬영 직후 호출
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let image = info[UIImagePickerController.InfoKey.editedImage/*originalImage*/] as? UIImage { //picker.allowsEditing = true을 이용하여 편집된 이미지를 넣고 싶은 경우 InfoKey.editedImage로 바꿔준다.
            self.imageView.image = image
            dismiss(animated: true)
        }
    }
    
    
}
