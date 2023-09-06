//
//  HomeViewController.swift
//  BookWorm
//
//  Created by hoon on 2023/09/04.
//

import UIKit
import SnapKit
import RealmSwift

class HomeViewController: UIViewController {
    
    let repository = BookTableRepository()
    
    let addButton = {
        let uibutton = UIButton()
        let buttonImage = UIImage.SymbolConfiguration(pointSize: 30, weight: .bold, scale: .small)
        let image = UIImage(systemName: "plus.circle", withConfiguration: buttonImage)
        uibutton.setImage(image, for: .normal)
        uibutton.tintColor = .blue
        return uibutton
    }()
    
    let filterButton = {
        let uibutton = UIButton()
        let buttonImage = UIImage.SymbolConfiguration(pointSize: 30, weight: .bold, scale: .small)
        let image = UIImage(systemName: "slider.horizontal.3", withConfiguration: buttonImage)
        uibutton.setImage(image, for: .normal)
        uibutton.tintColor = .blue
        return uibutton
    }()
    
    let backupButton = {
        let uibutton = UIButton()
        uibutton.setTitle("백/복", for: .normal)
        uibutton.setTitleColor(UIColor.blue, for: .normal)
        return uibutton
    }()
    
    let logoImage = {
        let view = UIImageView(frame: .zero)
        let confi = UIImage.SymbolConfiguration(pointSize: 20)
        view.image = UIImage(systemName: "books.vertical", variableValue: 0.1, configuration: confi)
        view.tintColor = .brown
        return view
    }()
    
    let titleLabel = {
        let label = UILabel()
        label.text = "BookWorm"
        label.font = .boldSystemFont(ofSize: 25)
        return label
    }()
    
    lazy var logoStackView: UIStackView = {
        let view = UIStackView(arrangedSubviews: [logoImage, titleLabel])
        view.axis = .horizontal
        view.alignment = .fill
        view.distribution = .fill
        view.spacing = 0
        return view
    }()
    
    let tableView = {
        let view = UITableView()
        view.rowHeight = UITableView.automaticDimension
        view.estimatedRowHeight = UITableView.automaticDimension
        view.register(HomeTableViewCell.self, forCellReuseIdentifier: "StoredCell")
        return view
    }()
    
    var stored: Results<BookTable>!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        setNavigationBar()
        
        configureView()
        setConstraints()
        
        tableView.delegate = self
        tableView.dataSource = self
        
        
        stored = repository.fetch(.added)
        
        setMenuButton()
        
        //realm경로 탐색
        repository.realmPathCheck()
        
        //스키마 버전
        repository.checkSchemaVersion()
    }
    
    
    private func setNavigationBar() {
        let search = UIBarButtonItem(customView: addButton)
        let filter = UIBarButtonItem(customView: filterButton)
        let backUp = UIBarButtonItem(customView: backupButton)
        navigationItem.rightBarButtonItems = [search, filter, backUp]
        
        let title = UIBarButtonItem(customView: logoStackView)
        navigationItem.leftBarButtonItem = title
        
        addButton.addTarget(self, action: #selector(addButtonClicked), for: .touchUpInside)
        
        navigationController?.hidesBarsOnSwipe = true
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        tableView.reloadData()
    }
    
    @objc func addButtonClicked() {
        let vc = SearchViewController()
        
        navigationController?.pushViewController(vc, animated: true)
    }
    
    func setMenuButton() {
        let case0 = UIAction(title: "all_추가된순") { _ in
            self.stored = self.repository.fetch(.added)
            self.tableView.reloadData()
        }
        let case1 = UIAction(title: "all_오름차순") { _ in
            self.stored = self.repository.fetch(.sorted)
            self.tableView.reloadData()
        }
        let case2 = UIAction(title: "all_내림차순") { _ in
            self.stored = self.repository.fetch(.reversed)
            self.tableView.reloadData()
        }
        let case3 = UIAction(title: "스위프트 관련여부") { _ in
            self.stored = self.repository.fetchFilter(kindOf: .containSwift)
            self.tableView.reloadData()
        }
        let case4 = UIAction(title: "memo 존재여부") { _ in
            self.stored = self.repository.fetchFilter(kindOf: .existMemo)
            self.tableView.reloadData()
        }
        filterButton.menu = UIMenu(title: "정렬방법을 선택해주세요", image: nil, identifier: nil, options: .displayInline, children: [case0, case1, case2, case3, case4])//UIMenu(title: "정렬", children: [case1, case2, case3])
        filterButton.showsMenuAsPrimaryAction = true
//        filterButton.changesSelectionAsPrimaryAction = true
        
        
        let backup = UIAction(title: "백업") {_ in
            print("백업")
        }
        
        let restore = UIAction(title: "복구") {_ in
            print("복구")
        }
        backupButton.menu = UIMenu(title: "백업/복구를 선택해주세요", children: [backup, restore])
        backupButton.showsMenuAsPrimaryAction = true
    }

    func configureView() {
        view.addSubview(tableView)
    }
    
    func setConstraints() {
        tableView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        logoImage.snp.makeConstraints { make in
            make.width.equalTo(logoStackView.snp.height).multipliedBy(1)
        }
    }


}

extension HomeViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return stored.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "StoredCell", for: indexPath) as! HomeTableViewCell
        
        let stored = self.stored[indexPath.row]
        
        cell.title.text = stored.bookTitle
        cell.author.text = stored.bookAuthor
        
//        let url = stored.posterURL
//
//        if let url = URL(string: url) {
//            cell.image.kf.setImage(with: url)
//        }
        
        cell.image.image = DocumentManager.shared.loadImageFromDocument(fileName: "JH\(stored._id)")

        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = DetailViewController()
        
        vc.data = stored[indexPath.row]
        
        navigationController?.pushViewController(vc, animated: true)
    }
    
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        
        let remove = UIContextualAction(style: .destructive, title: "삭제") { action, view, completionHandler in
            let data = self.stored[indexPath.row]
            
            DocumentManager.shared.removeImageFromDocument(fileName: "JH\(data._id)")
            
//            try! self?.realm.write {
//                self?.realm.delete(data!)
//            }
            
            self.repository.removeItem(data)
            
            tableView.reloadData()
        }
        remove.image = UIImage(systemName: "trash")
        
        
        return UISwipeActionsConfiguration(actions: [remove])
    }
    
    
    
}
