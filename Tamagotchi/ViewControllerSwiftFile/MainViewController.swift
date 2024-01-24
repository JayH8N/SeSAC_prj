//
//  ViewController.swift
//  Tamagotchi
//
//  Created by hoon on 2023/08/04.
//

import UIKit


class MainViewController: UIViewController {

    @IBOutlet var collectionView: UICollectionView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setBackgroundColor()
        self.title = "다마고치 선택하기"
        collectionViewDelegate()
        registerNib()
        configureCollectionViewlayout()
        collectionView.backgroundColor = themeColor
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        let titleBool = UserDefaults.standard.bool( forKey: ForKey.changeCharacter.rawValue)
        print("1")
        if !titleBool {
            self.title = "다마고치 선택하기"
        } else {
            self.title = "다마고치 변경하기"
        }
    }

    func collectionViewDelegate() {
            collectionView.delegate = self
            collectionView.dataSource = self
        }

    func registerNib() {
        let nib = UINib(nibName: MainCollectionViewCell.identifier, bundle: nil)
        collectionView.register(nib, forCellWithReuseIdentifier: MainCollectionViewCell.identifier)
        }

    func configureCollectionViewlayout() {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.itemSize = CGSize(width: 100, height: 140)
        layout.sectionInset = UIEdgeInsets(top: 10, left: 20, bottom: 0, right: 20)
        layout.minimumLineSpacing = 20

        collectionView.collectionViewLayout = layout
    }

}



extension MainViewController: UICollectionViewDelegate, UICollectionViewDataSource {

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return DetailTamagotchi.shared.list.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MainCollectionViewCell.identifier, for: indexPath) as! MainCollectionViewCell

        let item = DetailTamagotchi.shared.list[indexPath.item]
        cell.setCell(data: item)

        return cell
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let popUpView = self.storyboard?.instantiateViewController(withIdentifier: PopUpViewController.identifier) as! PopUpViewController

        let item = DetailTamagotchi.shared.list[indexPath.item]
        popUpView.callValue(data: item)
        

        popUpView.type = CharacterType(rawValue: indexPath.item)

        
        //???: - 이거 왜 값전달 옵셔널로 받지?
        //제네릭활용 함수 화면전환
        //transition(style: .present, sbName: "Main", viewController: PopUpViewController.self, PresentationStyle: .overFullScreen, animate: true)
        
        //기존 화면전환코드
        popUpView.modalPresentationStyle = .overFullScreen
        present(popUpView, animated: true)
    }
    
}

extension MainViewController: ReusableIdentifier {
    static var identifier: String {
        return String(describing: Self.self)
    }
}
