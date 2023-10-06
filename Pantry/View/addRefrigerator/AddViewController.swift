//
//  AddViewController.swift
//  Pantry
//
//  Created by hoon on 2023/10/03.
//

import UIKit
import SnapKit
import Then

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
        
        name.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview().inset(30)
            $0.top.equalTo(uiView.snp.bottom).offset(30)
            $0.height.equalTo(uiView.snp.height).multipliedBy(0.3)
        }
        
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
    }
}

extension AddViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    @objc func addButtonTapped() {
        let data = Refrigerator(name: name.text ?? "", memo: memo.text ?? "")

        DocumentManager.shared.saveImageToDocument(fileName: "JH\(data._id)", image: (selectedImage ?? UIImage(named: "basicRefiger"))!)

        repository.createItem(data)
                
        dismiss(animated: true)
    }
    
    @objc func cancelButtonTapped() {
        dismiss(animated: true)
    }
    
    @objc func imageViewTapped() {
        let imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        
        let alertController = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        
        // 카메라로 찍기
        let cameraAction = UIAlertAction(title: NSLocalizedString("Camera", comment: ""), style: .default) { _ in
            if UIImagePickerController.isSourceTypeAvailable(.camera) {
                imagePicker.sourceType = .camera
                self.present(imagePicker, animated: true, completion: nil)
            } else {
                self.showAlert(message: NSLocalizedString("NoCamera", comment: ""))
            }
        }
        
        // 앨범에서 선택
        let libraryAction = UIAlertAction(title: NSLocalizedString("Album", comment: ""), style: .default) { _ in
            imagePicker.sourceType = .photoLibrary
            self.present(imagePicker, animated: true, completion: nil)
        }
        
        // 취소
        let cancelAction = UIAlertAction(title: NSLocalizedString("Cancel", comment: ""), style: .cancel, handler: nil)
        
        alertController.addAction(cameraAction)
        alertController.addAction(libraryAction)
        alertController.addAction(cancelAction)
        
        present(alertController, animated: true, completion: nil)
    }
    
    //이미지 선택 후 or 촬영 후 호출
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let pickedImage = info[.originalImage] as? UIImage {
            imageView.image = pickedImage
            selectedImage = pickedImage
        }
        picker.dismiss(animated: true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
    }
    
    func showAlert(message: String) {
        let alertController = UIAlertController(title: "알림", message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "확인", style: .default, handler: nil)
        alertController.addAction(okAction)
        present(alertController, animated: true, completion: nil)
    }
    
}
