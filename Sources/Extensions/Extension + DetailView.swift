//
//  File.swift
//  Media
//
//  Created by hoon on 2023/08/20.
//

import UIKit

extension DetailViewController: Reusableidentifier {
    static var identifier: String {
        return String(describing: Self.self)
    }
}

extension DetailViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "Cast"
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return creditList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: CastTableViewCell.identifier) as! CastTableViewCell
        
        let row = creditList[indexPath.row]
        
        cell.setCell(row: row)
        
        return cell
    }
    
    
}
