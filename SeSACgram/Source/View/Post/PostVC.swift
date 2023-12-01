//
//  PostVC.swift
//  SeSACgram
//
//  Created by hoon on 11/30/23.
//

import UIKit

final class PostVC: BaseVC {
    
    private let mainView = PostView()
    
    override func loadView() {
        self.view = mainView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initNav()
        self.hideKeyboardWhenTappedAround()
        mainView.imagePickerCollectionView.delegate = self
        mainView.imagePickerCollectionView.dataSource = self
    }
    
    private func initNav() {
        self.navigationItem.title = "새 게시물"
        
        let cancelButton = UIBarButtonItem(title: "닫기", style: .done, target: self, action: #selector(cancelButtonTapped))
        
        self.navigationItem.setLeftBarButton(cancelButton, animated: true)
        cancelButton.tintColor = Constants.Color.DeepGreen
    }
    
    @objc private func cancelButtonTapped() {
        dismiss(animated: true)
    }
    
}

extension PostVC: AddTargetProtocol {
    func addTargets() {
        mainView.postButton.addTarget(self, action: #selector(postButtonTapped), for: .touchUpInside)
    }
    
    @objc private func postButtonTapped() {
        //api요청, 성공시 dismiss
        
    }
}

extension PostVC: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 5
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if indexPath.item == 0 {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ImagePickerCell().description,
                                                          for: indexPath) as! ImagePickerCell
            return cell
        } else {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: AddedImageCell().description,
                                                          for: indexPath) as! AddedImageCell
            return cell
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print("셀 클릭")
    }
}
