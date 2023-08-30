//
//  PhotoHomeViewController.swift
//  Diary
//
//  Created by hoon on 2023/08/30.
//

import UIKit

class PhotoHomeViewController: BaseViewController {
    
    let mainView = PhotoHomeView()
    
    override func loadView() {
        self.view = mainView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        guard UIImagePickerController.isSourceTypeAvailable(.photoLibrary) else { //.photoLibrary
            return
        }
        mainView.picker.delegate = self
        mainView.picker.sourceType = .photoLibrary
        
        NotificationCenter.default.addObserver(self, selector: #selector(selectedImage), name: Notification.Name("SelectedImage"), object: nil)
    }
    
    @objc func selectedImage(notification: NSNotification) {
        if let url = notification.userInfo?["url"] as? String {
            mainView.mainImageView.kf.setImage(with: URL(string: url))
            }
        }
    
    
    
    override func configureView() {
        super.configureView()
        mainView.addButton.addTarget(self, action: #selector(addButtonClicked), for: .touchUpInside)
    }
    
    
    override func setConstraints() {
        super.setConstraints()
    }
    
    //MARK: - @objc
    
    @objc func addButtonClicked() {
        showAlertView(title: nil) { action in
            self.present(self.mainView.picker, animated: true)
        } handler2: { action in
            let vc = WebSearchViewController()
            self.present(vc, animated: true)
        }

    }
    
    
    
    
    
}

extension PhotoHomeViewController {
    func showAlertView(title: String? = nil, message: String? = nil, handler1: @escaping (UIAlertAction) -> Void, handler2: @escaping (UIAlertAction) -> Void) {
        
        let alert = UIAlertController(title: title, message: message, preferredStyle: .actionSheet)
       
        let gallery = UIAlertAction(title: "갤러리에서 가져오기", style: .default, handler: handler1)
        let webSearch = UIAlertAction(title: "웹에서 검색하기", style: .default, handler: handler2)
        let cancel = UIAlertAction(title: "취소", style: .cancel)
        
        alert.addAction(gallery)
        alert.addAction(webSearch)
        alert.addAction(cancel)
        
        // 4. alert present하기
        present(alert, animated: true, completion: nil)
    }
}


extension PhotoHomeViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    //취소버튼
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true)
       
    }
    
    
    //사진을 선택
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
            mainView.mainImageView.image = image
            dismiss(animated: true)
        }
    }
    
    
    
}
