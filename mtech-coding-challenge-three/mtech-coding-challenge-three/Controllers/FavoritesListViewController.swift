//
//  FavoritesListViewController.swift
//  mtech-coding-challenge-three
//
//  Created by Justin Snider on 5/20/19.
//  Copyright © 2019 Justin Snider. All rights reserved.
//

import UIKit

class FavoritesListViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UISearchBarDelegate {
    
    //========================================
    //MARK: - IBOutlets
    //========================================
    
    @IBOutlet weak var tableView: UITableView!
    
    //========================================
    //MARK: - Search Bar Delegate Methods
    //========================================
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
    }
    
    //========================================
    //MARK: - Table View Data and Delegate Methods
    //========================================
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return MovieController.shared.favorites.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "favoriteCell", for: indexPath)
        let currentSearchItem = MovieController.shared.favorites[indexPath.row]
        
        cell.textLabel?.text = currentSearchItem.title
        cell.detailTextLabel?.text = currentSearchItem.year
        
        cell.imageView?.image = MovieController.shared.favoriteImages[indexPath.row]
        
        return cell
    }

    //========================================
    //MARK: - Life Cycle Methods
    //========================================
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        guard let favorites = SearchItem.loadFromFile() else { return }
        
        MovieController.shared.favorites.append(contentsOf: favorites)
    }
}
