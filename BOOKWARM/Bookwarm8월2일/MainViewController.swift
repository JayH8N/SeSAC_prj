//
//  MainViewController.swift
//  BOOKWARM
//
//  Created by hoon on 2023/08/02.
//

import UIKit

class MainViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UITableViewDataSource, UITableViewDelegate  {

    
    var movie = MovieInfo()
    var book = BookInfo()
    
    @IBOutlet var bestBookCollection: UICollectionView!
    @IBOutlet var collectionViewTitle: UILabel!
    
    
    @IBOutlet var movieTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        self.title = "둘러보기"
        self.tabBarController?.tabBar.items![0].image = UIImage(systemName: "star.fill")
      
        collectionViewTitle.setLabel(title: "베스트 셀러")
        
        
        bestBookCollection.delegate = self
        bestBookCollection.dataSource = self
        
        let nib = UINib(nibName: BestsellerCollectionViewCell.idenifier, bundle: nil)
        bestBookCollection.register(nib, forCellWithReuseIdentifier: BestsellerCollectionViewCell.idenifier)
        configureCollectionViewLayout()
        
        movieTableView.delegate = self
        movieTableView.dataSource = self
        movieTableView.rowHeight = 130
    }
    
    //MARK: - CollectionView
    func configureCollectionViewLayout() {
        
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.itemSize = CGSize(width: 100, height: 120)
        layout.sectionInset = UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 20)
        
        bestBookCollection.collectionViewLayout = layout
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return book.book.count
    }
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: BestsellerCollectionViewCell.idenifier, for: indexPath) as! BestsellerCollectionViewCell
        
        let item = book.book[indexPath.item]
        cell.setCell(item: item)
        
        return cell
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let sb = UIStoryboard(name: "DetailScreen", bundle: nil)
        let vc = sb.instantiateViewController(identifier: BookDetailViewController.identifier) as! BookDetailViewController
        let item = book.book[indexPath.item]
        
        //???: -
        vc.title = item.title
        vc.cover = item.image
        vc.writer = item.author
        // Struct

        let nav = UINavigationController(rootViewController: vc)
        nav.modalPresentationStyle = .fullScreen
        
        present(nav, animated: true)
    }
    
    
    //MARK: - TableView
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "요즘 인기 작품"
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return movie.movie.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: MovieDetailTableViewCell.identifier) as! MovieDetailTableViewCell
        
        let row = movie.movie[indexPath.row]
        
        cell.setCell(row: row)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let sb = UIStoryboard(name: "Main", bundle: nil)
        let vc = sb.instantiateViewController(identifier: MovieInfoViewController.identifier) as! MovieInfoViewController
        
        let data = movie.movie[indexPath.row]
        vc.self.title = data.title
        vc.setCell(data: data)
        
        vc.type = .present
        let nav = UINavigationController(rootViewController: vc)
        nav.modalPresentationStyle = .fullScreen
        
        present(nav, animated: true)
        
        //tableView.reloadSections([indexPath.row], with: .none)
    }

}
