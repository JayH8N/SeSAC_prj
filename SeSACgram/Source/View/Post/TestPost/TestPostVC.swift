//
//  TestPostVC.swift
//  SeSACgram
//
//  Created by hoon on 12/6/23.
//

import UIKit

final class TestPostVC: BaseVC {
    
    private let mainView = TestPostView()
    
    override func loadView() {
        self.view = mainView
    }
    
    override func viewDidLoad() {
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

extension TestPostVC: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 20
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ImagePickerCell().description,
                                                      for: indexPath)
        cell.backgroundColor = .yellow
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print("000-----0000")
    }
}
