//
//  MovieTableViewController.swift
//  SeSAC_Week3
//
//  Created by hoon on 2023/07/28.
//

import UIKit




class MovieTableViewController: UITableViewController {
    
    let movie = MovieInfo()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.rowHeight = 140
        
    }
    
    
    
    
    //3. 셀 갯수(필수)
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return movie.movie.count
    }
    
    
    
    
    
    //4. 셀 데이터 및 디자인 처리(필수)
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "MovieList") as! MovieList
        
        let row = movie.movie[indexPath.row]
        
        cell.configureCell(row: row)
        
        return cell
    }
    
    
    
    
    
    
    
}
