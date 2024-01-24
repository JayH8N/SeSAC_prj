//
//  SearchViewController.swift
//  SeSAC3Week10
//
//  Created by hoon on 2023/09/21.
//

import UIKit
import SnapKit

class SearchViewController: UIViewController {
    
    let list = Array(0...100)
    
    
    var collectionView = UICollectionView(frame: .zero, collectionViewLayout: configureCollectionLayout())
    
    var dataSource: UICollectionViewDiffableDataSource<Int, Int>! //=> 클래스이기에 상속을 이용해 코드줄이는 것 가능
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureHierarchy()
        configureDataSource()
        configureLayout()
        
       //collectionView.register(SearchCollectionViewCell.self, forCellWithReuseIdentifier: "cell")
    }
    
    static func configureCollectionLayout() -> UICollectionViewLayout {
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: 50, height: 50)
        layout.scrollDirection = .vertical
        return layout
    }
    
    func configureLayout() {
        collectionView.snp.makeConstraints { make in
            make.edges.equalTo(view.safeAreaLayoutGuide)
        }
    }
    
    func configureHierarchy() {
        view.addSubview(collectionView)
    }
    
    
    func configureDataSource() {
        
        //어떤 셀을 사용할지, 어떤 데이터를 사용할지 지정 => 제네릭으로 지정
        let cellRegistration = UICollectionView.CellRegistration<SearchCollectionViewCell, Int> { cell, indexPath, itemIdentifier in
            cell.imageView.image = UIImage(systemName: "star")
            cell.label.text = "\(itemIdentifier)번"
        }
        
        dataSource = UICollectionViewDiffableDataSource(collectionView: collectionView, cellProvider: { collectionView, indexPath, itemIdentifier in
            
            return collectionView.dequeueConfiguredReusableCell(using: cellRegistration, for: indexPath, item: itemIdentifier)
            
        })
        
        
        //데이터 소스 제너릭타입과 통일시킨다.
        var snapshot = NSDiffableDataSourceSnapshot<Int, Int>()
        snapshot.appendSections([0])
        snapshot.appendItems(list)
        dataSource.apply(snapshot)
        
    }
    
    
//    func numberOfSections(in collectionView: UICollectionView) -> Int {
//        return 1
//    }
//
//    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
//        return list.count
//    }
//
//    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
//        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! SearchCollectionViewCell
//        cell.label.text = "\(list[indexPath.item])번"
//        return cell
//    }
    
}



//class SearchViewController: UIViewController {
//
//    let scrollView = UIScrollView()
//    let contentView = UIView()
//
//    let imageView = UIImageView()
//    let label = UILabel()
//    let button = UIButton()
//
//
//    override func viewDidLoad() {
//        super.viewDidLoad()
//
//        configureHierarchy()
//        configureLayout()
//        configureContentView()
//    }
//
//    func configureContentView() {
//        contentView.addSubview(imageView)
//        contentView.addSubview(button)
//        contentView.addSubview(label)
//
//        imageView.backgroundColor = .orange
//        button.backgroundColor = .magenta
//        label.backgroundColor = .systemGreen
//
//        imageView.snp.makeConstraints { make in
//            make.top.horizontalEdges.equalTo(contentView).inset(10)
//            make.height.equalTo(200)
//        }
//
//        button.snp.makeConstraints { make in
//            make.bottom.horizontalEdges.equalTo(contentView).inset(10)
//            make.height.equalTo(80)
//        }
//
//        //label은 높이가 동적으로 변하도록
//        label.text = "texttexttexttexttexttexttext\nttexttexttexttexttexttexttext\nttexttexttexttexttexttexttext\nttexttexttexttexttexttexttext\nttexttexttexttexttexttexttext\nttexttexttexttexttexttexttext\nttexttexttexttexttexttexttext\nttexttexttexttexttexttexttext\nttexttexttexttexttexttexttext\nttexttexttexttexttexttexttext\nttexttexttexttexttexttexttext\nttexttexttexttexttexttexttext\nttexttexttexttexttexttexttext\nttexttexttexttexttexttexttext\nttexttexttexttexttexttexttext\nttexttexttexttexttexttexttext\nttexttexttexttexttexttexttext\nttexttexttexttexttexttexttext\ntexttexttexttext\ntexttexttexttext\ntexttexttexttext\ntexttexttexttext\ntexttexttexttext\ntexttexttext\ntexttexttext\ntexttexttexttexttext\ntexttexttext\ntexttexttexttext\ntexttexttexttexttext\ntexttexttexttext"
//        label.numberOfLines = 0
//        label.textColor = .red
//        label.snp.makeConstraints { make in
//            make.horizontalEdges.equalTo(contentView)
//            make.top.equalTo(imageView.snp.bottom).offset(50)
//            make.bottom.equalTo(button.snp.top).offset(-50)
//        }
//    }
//
//
//    func configureHierarchy() {
//        view.addSubview(scrollView)
//        scrollView.addSubview(contentView)
//    }
//
//
//    func configureLayout() {
//        scrollView.bounces = false //스크롤뷰 바운스 효과
//        scrollView.showsVerticalScrollIndicator = false
//        scrollView.backgroundColor = .lightGray
//        scrollView.snp.makeConstraints { make in
//            make.edges.equalTo(view.safeAreaLayoutGuide)
//        }
//
//
//
//        contentView.backgroundColor = .white
//        contentView.snp.makeConstraints { make in
//            make.verticalEdges.equalTo(scrollView)
//            make.width.equalTo(scrollView.snp.width)
//        }
//    }
//
//
//}

//class SearchViewController: UIViewController {
//
//    //셀이 많이 추가될일이 없고 어느정도 고정적으로 예상된다면 컬렉션뷰보다는 스크롤뷰
//    let scrollView = UIScrollView()
//    let stackview = UIStackView()
//
//
//    override func viewDidLoad() {
//        super.viewDidLoad()
//
//        configureHierarchy()
//        configureLayout()
//        configureStackView()
//
//        view.backgroundColor = .white
//
//    }
//
//
//    func configureHierarchy() {
//        view.addSubview(scrollView)
//        scrollView.addSubview(stackview)
//    }
//
//
//    func configureLayout() {
//        scrollView.backgroundColor = .lightGray
//        scrollView.showsHorizontalScrollIndicator = false
//        scrollView.snp.makeConstraints { make in
//            make.top.horizontalEdges.equalTo(view.safeAreaLayoutGuide)
//            make.height.equalTo(50)
//        }
//
//        stackview.spacing = 16
//        stackview.backgroundColor = .blue
//        stackview.snp.makeConstraints { make in
//            make.edges.equalTo(scrollView)
//            make.height.equalTo(50)
//        }
//    }
//
//    func configureStackView() {
//        let label1 = UILabel()
//        label1.text = "안녕하세요"
//        label1.backgroundColor = .green
//        label1.textColor = .white
//        stackview.addArrangedSubview(label1)
//
//        let label2 = UILabel()
//        label2.text = "안녕하세요dfdf"
//        label2.layer.cornerRadius = 10
//        label2.layer.borderColor = UIColor.systemPink.cgColor
//        label2.textColor = .white
//        stackview.addArrangedSubview(label2)
//
//        let label3 = UILabel()
//        label3.text = "안녕하세요dd"
//        label3.textColor = .white
//        stackview.addArrangedSubview(label3)
//
//        let label4 = UILabel()
//        label4.text = "안녕하세요ssss"
//        label4.textColor = .white
//        stackview.addArrangedSubview(label4)
//
//        let label5 = UILabel()
//        label5.text = "안녕하세요sdfasdfasdf"
//        label5.textColor = .white
//        stackview.addArrangedSubview(label5)
//    }
//
//
//
//}
