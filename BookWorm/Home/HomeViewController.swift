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
    
    let realm = try! Realm()
    
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
        title = "BOOKWORM"
        setNavigationBar()
        
        configureView()
        setConstraints()
        
        tableView.delegate = self
        tableView.dataSource = self
        
        
        stored = realm.objects(BookTable.self)
        //print(realm.configuration.fileURL)
    }
    
    
    private func setNavigationBar() {
        let search = UIBarButtonItem(customView: addButton)
        let filter = UIBarButtonItem(customView: filterButton)
        navigationItem.rightBarButtonItems = [search, filter]
        
        addButton.addTarget(self, action: #selector(addButtonClicked), for: .touchUpInside)
        filterButton.addTarget(self, action: #selector(filterButtonClicked), for: .touchUpInside)
        
        navigationController?.hidesBarsOnSwipe = true
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        tableView.reloadData()
    }
    
    
    @objc func filterButtonClicked() {
        
    }
    
    
    @objc func addButtonClicked() {
        let vc = SearchViewController()
        
        navigationController?.pushViewController(vc, animated: true)
    }

    func configureView() {
        view.addSubview(tableView)
    }
    
    func setConstraints() {
        tableView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
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
        
        let like = UIContextualAction(style: .destructive, title: "삭제") { [weak self] action, view, completionHandler in
            let data = self?.stored[indexPath.row]
            
            DocumentManager.shared.removeImageFromDocument(fileName: "JH\(data!._id)")
            
            try! self?.realm.write {
                self?.realm.delete(data!)
            }
            
            tableView.reloadData()
        }
        like.image = UIImage(systemName: "trash")
        
        
        return UISwipeActionsConfiguration(actions: [like])
    }
    
    
    
}
