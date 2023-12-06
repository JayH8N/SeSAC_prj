//
//  PostVC.swift
//  SeSACgram
//
//  Created by hoon on 11/30/23.
//

import UIKit
import YPImagePicker
import RxCocoa
import RxSwift

final class PostVC: BaseVC, UINavigationControllerDelegate {
    private let disposeBag = DisposeBag()
//    private var selectedImage: [UIImage] = [] {
//        didSet {
//            self.reloadCollectionView()
//        }
//    }
    private var selectedImages = BehaviorSubject<[UIImage]>(value: [])
    //배열을 Observable로 변환하여 combinlatest에 활용
    
    private let mainView = PostView()
    
    override func loadView() {
        self.view = mainView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        mainView.imagePickerCollectionView.delegate = self
        mainView.imagePickerCollectionView.dataSource = self
        initNav()
        self.hideKeyboardWhenTappedAround()
        bind()
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
    
    private func bind() {
        let title = mainView.titleTextField.rx.text.orEmpty
        let contentText = mainView.contentTextView.rx.text.orEmpty
        
        let validation = Observable.combineLatest(title, contentText, selectedImages) { first, second, third in
            return first.count > 0 && second.count > 0 && !third.isEmpty
        }
        
        validation
            .bind(to: mainView.postButton.rx.isEnabled)
            .disposed(by: disposeBag)
        
        validation
            .subscribe(with: self) { owner, value in
                owner.mainView.postButton.setBackgroundColor(value ? Constants.Color.DeepGreen : UIColor.gray
                                                             , for: .normal)
            }
            .disposed(by: disposeBag)
        
        selectedImages
            .subscribe(with: self) { owner, _ in
                owner.reloadCollectionView()
            }
            .disposed(by: disposeBag)
    }
    
    private func presentImagePicker() {
        var config = YPImagePickerConfiguration()
        config.startOnScreen = .library // 첫 시작시 앨범이 default
        config.shouldSaveNewPicturesToAlbum = true // YPImagePicker의 카메라로 찍은 사진 핸드폰에 저장하기
        config.showsPhotoFilters = true // 이미지 필터 사용여부
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
                    //self.selectedImages.append(photo.image)
                    var currentImages = try! self.selectedImages.value()
                    currentImages.append(photo.image)
                    self.selectedImages.onNext(currentImages)
                }
            }
            picker.dismiss(animated: true)
        }
        
        present(picker, animated: true)
    }
    
    private func reloadCollectionView() {
        mainView.imagePickerCollectionView.reloadData()
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
        var count = try! selectedImages.value().count
        return 1 + count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if indexPath.item == 0 {
            let count = try! selectedImages.value().count
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ImagePickerCell().description,
                                                          for: indexPath) as! ImagePickerCell
            cell.updateLabel(count: count)
            return cell
        } else {
            let images = try! selectedImages.value()
            let target = images[indexPath.item - 1]
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: AddedImageCell().description,
                                                          for: indexPath) as! AddedImageCell
            cell.setImage(image: target, indexPath: indexPath.item)
            cell.removeDelegate = self
            return cell
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if indexPath.item == 0 {
            self.presentImagePicker()
        }
    }
}

extension PostVC: RemoveImageProtocol {
    func removeImage(indexPath: Int) {
        print("dfdf")
        let target = indexPath - 1
        var images = try! selectedImages.value()
        images.remove(at: target)
        selectedImages.onNext(images)
    }
}
