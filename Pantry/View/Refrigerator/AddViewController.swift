//
//  AddViewController.swift
//  Pantry
//
//  Created by hoon on 2023/10/03.
//

import UIKit
import SnapKit
import Then
import YPImagePicker

class AddViewController: BaseViewController {
    
    
    var selectedImage: UIImage?
    
    
    let viewModel = AddViewModel()
    let repository = RefrigeratorRepository()
    
    let blurEffect = UIVisualEffectView(effect: UIBlurEffect(style: .light))
    
    let uiView = UIView().then {
        $0.layer.cornerRadius = 10
        $0.layer.masksToBounds = true
    }
    
    let imageView = UIImageView().then {
        $0.image = UIImage(named: "basicRefiger")
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
        setBind()
        
        self.hideKeyboardWhenTappedAround()
    }
    
    private func setBind() {
        viewModel.name.bind { [weak self] name in
            self?.name.text = name
            self?.viewModel.isValid.value = !name.isEmpty
        }
        
        viewModel.isValid.bind { [weak self] isValid in
            self?.navigationItem.rightBarButtonItem?.isEnabled = isValid
        }
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
        
        name.addTarget(self, action: #selector(nameTextChanged), for: .editingChanged)
        memo.addTarget(self, action: #selector(memoTextChanged), for: .editingChanged)
    }
    
    @objc func nameTextChanged() {
        viewModel.name.value = name.text ?? ""
    }
    
    @objc func memoTextChanged() {
        viewModel.memo.value = memo.text ?? ""
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

extension AddViewController {
    private func initNav() {
        let addRefriger = NSLocalizedString("AddRefriger", comment: "")
        let cancel = NSLocalizedString("Cancel", comment: "")
        let add = NSLocalizedString("Add", comment: "")
        
        self.navigationItem.title = addRefriger
        self.navigationItem.rightBarButtonItem = .init(title: add, style: .done, target: self, action: #selector(addButtonTapped))
        self.navigationItem.leftBarButtonItem = .init(title: cancel, style: .done, target: self, action: #selector(cancelButtonTapped))
        
        navigationItem.rightBarButtonItem?.tintColor = UIColor.blue
        navigationItem.leftBarButtonItem?.tintColor = UIColor.red
    }
}

extension AddViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    @objc func addButtonTapped() {
        let data = Refrigerator(name: name.text ?? "", memo: memo.text ?? "")

        DocumentManager.shared.saveImageToDocument(fileName: "JH\(data._id)", image: (selectedImage ?? UIImage(named: "basicRefiger"))!)

        repository.createItem(data)

        NotificationCenter.default.post(name: Notification.Name("ReloadData"), object: nil)
        
        dismiss(animated: true)
    }
    
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
                self.selectedImage = photo.image
            }
            
            picker.dismiss(animated: true, completion: nil)
        }
        
        // YPImagePicker를 표시
        present(picker, animated: true, completion: nil)
    }
    
}
