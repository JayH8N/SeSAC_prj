//
//  PostVC.swift
//  SeSACgram
//
//  Created by hoon on 11/30/23.
//

import UIKit
import YPImagePicker

final class PostVC: BaseVC, UINavigationControllerDelegate {
    private var selectedImage: [UIImage] = []
    
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
    
    private func presentImagePicker() {
        var config = YPImagePickerConfiguration()
        config.startOnScreen = .library // 첫 시작시 앨범이 default
        config.shouldSaveNewPicturesToAlbum = true // YPImagePicker의 카메라로 찍은 사진 핸드폰에 저장하기
        config.showsPhotoFilters = true // 이미지 필터 사용하지 않기
        config.library.defaultMultipleSelection = true // 한장 선택 default (여러장 선택x)
        config.library.maxNumberOfItems = 4 // 사진 최대 선택 개수
        config.library.mediaType = .photo // 옵션 : photo, video, photo and video
        config.overlayView?.contentMode = .scaleAspectFit // 사진 스케일
        
        let picker = YPImagePicker(configuration: config)
        picker.delegate = self
        //이미지 선택 완료시
        picker.didFinishPicking { [unowned picker] items, _ in
            for item in items {
                if case let .photo(photo) = item {
                    self.selectedImage.append(photo.image)
                }
            }
            
            picker.dismiss(animated: true, completion: nil)
        }
        
        present(picker, animated: true)
    }
    
    deinit {
        print("====\(Self.self)====Deinit")
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
        print("=-=-=--")
    }
}
