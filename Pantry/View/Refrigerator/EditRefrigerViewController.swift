//
//  EditRefrigerViewController.swift
//  Pantry
//
//  Created by hoon on 2023/10/12.
//

import UIKit
import SnapKit
import Then
import YPImagePicker

class EditRefrigerViewController: BaseViewController {
    
    let repository = RefrigeratorRepository()
    
    var data: Refrigerator?
    
//MARK: - Properties
    let blurEffect = UIVisualEffectView(effect: UIBlurEffect(style: .light))
    
    let uiView = UIView().then {
        $0.layer.cornerRadius = 10
        $0.layer.masksToBounds = true
    }
    
    let imageView = UIImageView().then {
        $0.contentMode = .scaleAspectFill
    }
    
    let editLabel = UILabel().then {
        $0.text = NSLocalizedString("Edit", comment: "")
        $0.textColor = .white
        $0.backgroundColor = .darkGray.withAlphaComponent(0.6)
        $0.textAlignment = .center
        $0.font = .systemFont(ofSize: 16)
    }
    
    let name = UITextField().then {
        $0.placeholder = NSLocalizedString("EnterTitle", comment: "")
        $0.attributedPlaceholder = NSAttributedString(string: $0.placeholder ?? "",
                                                      attributes: [NSAttributedString.Key.foregroundColor: UIColor.red])
        $0.tintColor = .black
        $0.layer.cornerRadius = 10
        $0.backgroundColor = .white
    }
    
    let memo = UITextField().then {
        $0.placeholder = NSLocalizedString("Memo", comment: "")
        $0.tintColor = .black
        $0.layer.cornerRadius = 10
        $0.backgroundColor = .white
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        initNav()
        
        initialSetting()
        self.hideKeyboardWhenTappedAround()
    }
    
    private func initialSetting() {
        
        guard let data = data else { return }
        
        imageView.image = DocumentManager.shared.loadImageFromDocument(fileName: "JH\(data._id)")
        
        name.text = data.name
        memo.text = data.memo
    }
    
    override func configureView() {
        view.addSubview(blurEffect)
        view.addSubview(uiView)
        uiView.addSubview(imageView)
        uiView.addSubview(editLabel)
        uiView.isUserInteractionEnabled = true
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(imageViewTapped))
        uiView.addGestureRecognizer(tapGesture)
        
        view.addSubview(name)
        view.addSubview(memo)
    }
    
    override func setConstraints() {
        blurEffect.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
        uiView.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.centerY.equalToSuperview().multipliedBy(0.4)
            $0.size.equalTo(view.snp.width).multipliedBy(0.4)
        }
        
        imageView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
        editLabel.snp.makeConstraints {
            $0.leading.trailing.bottom.equalToSuperview()
            $0.height.equalTo(uiView.snp.height).multipliedBy(0.23)
        }
        
        
        name.leftView = UIView(frame: CGRect(x: 0.0, y: 0.0, width: 10.0, height: 0.0))
        name.leftViewMode = .always
        name.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview().inset(30)
            $0.top.equalTo(uiView.snp.bottom).offset(30)
            $0.height.equalTo(uiView.snp.height).multipliedBy(0.3)
        }
        
        memo.leftView = UIView(frame: CGRect(x: 0.0, y: 0.0, width: 10.0, height: 0.0))
        memo.leftViewMode = .always
        memo.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview().inset(30)
            $0.top.equalTo(name.snp.bottom).offset(30)
            $0.height.equalTo(name)
        }
    }
    
    
}

extension EditRefrigerViewController {
    private func initNav() {
        let editRefriger = NSLocalizedString("Edit", comment: "")
        let cancel = NSLocalizedString("Cancel", comment: "")
        let update = NSLocalizedString("Update", comment: "")
        let delete = NSLocalizedString("Delete", comment: "")
        
        self.navigationItem.title = editRefriger
        
        let editButton = UIBarButtonItem(title: update, style: .done, target: self, action: #selector(editButtonTapped))
        let deleteButton = UIBarButtonItem(title: delete, style: .done, target: self, action: #selector(deleteButtonTapped))
        let cancelButton = UIBarButtonItem(title: cancel, style: .done, target: self, action: #selector(cancelButtonTapped))
        
        navigationItem.setRightBarButtonItems([editButton, deleteButton], animated: false)
        navigationItem.setLeftBarButton(cancelButton, animated: false)
        
        editButton.tintColor = .blue
        deleteButton.tintColor = .red
        
        navigationItem.leftBarButtonItem?.tintColor = UIColor.red
    }
}

extension EditRefrigerViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    //수정
    @objc func editButtonTapped() {
         
        guard let data = data else { return }
        
        repository.updateItem(id: data._id, name: name.text ?? "", memo: memo.text ?? "")
        
        DocumentManager.shared.saveImageToDocument(fileName: "JH\(data._id)", image: imageView.image!)
        
        NotificationCenter.default.post(name: Notification.Name("ReloadData"), object: nil)
        
        dismiss(animated: true)
    }
    
    
    //삭제
    @objc func deleteButtonTapped() {
        
        guard let data = data else { return }
        
        DocumentManager.shared.removeImageFromDocument(fileName: "JH\(data._id)")
        
        repository.removeItem(data)
        
        NotificationCenter.default.post(name: Notification.Name("ReloadData"), object: nil)
        
        dismiss(animated: true)
    }
    
    
    //취소
    @objc func cancelButtonTapped() {
        dismiss(animated: true)
    }
    
    @objc func imageViewTapped() {

        var config = YPImagePickerConfiguration()
        config.library.onlySquare = true
        config.startOnScreen = .photo
        let picker = YPImagePicker(configuration: config)
        
        // 이미지 선택이 완료
        picker.didFinishPicking { [unowned picker] items, _ in
            if let photo = items.singlePhoto {
                self.imageView.image = photo.image
            }
            
            picker.dismiss(animated: true, completion: nil)
        }
        
        // YPImagePicker를 표시
        present(picker, animated: true, completion: nil)
    }
    
}
