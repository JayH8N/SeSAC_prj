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
    
    
    let addButton = {
        let uibutton = UIButton()
        let buttonImage = UIImage.SymbolConfiguration(pointSize: 30, weight: .bold, scale: .small)
        let image = UIImage(systemName: "plus.circle", withConfiguration: buttonImage)
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
        
        let search = UIBarButtonItem(customView: addButton)
        navigationItem.rightBarButtonItem = search
        
        addButton.addTarget(self, action: #selector(addButtonClicked), for: .touchUpInside)
        
        configureView()
        setConstraints()
        
        tableView.delegate = self
        tableView.dataSource = self
        
        let realm = try! Realm()
        
        stored = realm.objects(BookTable.self)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        tableView.reloadData()
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
            make.edges.equalTo(view.safeAreaLayoutGuide)
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
        let url = stored.posterURL
        
        if let url = URL(string: url) {
            cell.image.kf.setImage(with: url)
        }

        
        return cell
    }
    
    
}
