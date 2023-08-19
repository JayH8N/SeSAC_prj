//
//  Extension + MainView.swift
//  Media
//
//  Created by hoon on 2023/08/19.
//

import UIKit

//identifier
extension MainViewController: Reusableidentifier {
    static var identifier: String {
        return String(describing: Self.self)
    }
}


//tavleViewCell 등록
extension MainViewController: TableViewAttributeProtocol {
    func tableViewDelegate() {
        tableView.dataSource = self
        tableView.delegate = self
    }
    
    func registerNib() {
        let nib = UINib(nibName: MainViewTableViewCell.identifier, bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: MainViewTableViewCell.identifier)
    }
}

//tableView
extension MainViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 430
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return list.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: MainViewTableViewCell.identifier) as? MainViewTableViewCell else { return UITableViewCell() }
        
        cell.setCelldata(data: list[indexPath.row])
        cell.genreLabel.text = "#\(genre[list[indexPath.row].genreIDS[0]]!)"
        return cell
    }
    

}


//searchBar
extension MainViewController: UISearchBarDelegate {
    func settingButton() {
        let searchButton = UIImage(systemName: "magnifyingglass")
        navigationItem.rightBarButtonItem = UIBarButtonItem.init(image: searchButton, style: .plain, target: self, action: #selector(searchButtonClicked))
    }
    
    @objc
    func searchButtonClicked(_ sender: UIBarButtonItem) {
        searchBar.isHidden.toggle()
    }
}
