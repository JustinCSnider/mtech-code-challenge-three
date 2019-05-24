//
//  MovieListViewController.swift
//  mtech-coding-challenge-three
//
//  Created by Justin Snider on 5/20/19.
//  Copyright © 2019 Justin Snider. All rights reserved.
//

import UIKit

protocol favoriteButtonDelegate {
    func favoriteButtonTapped(sender: UIButton)
}

class SearchListViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UISearchBarDelegate, favoriteButtonDelegate {
    
    //========================================
    //MARK: - Properties
    //========================================
    
    var searchItems: [SearchItem] = []
    var searchItemImages: [UIImage] = []
    
    //========================================
    //MARK: - IBOutlets
    //========================================
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var loadingView: UIView!
    @IBOutlet weak var loadingActivityIndicator: UIActivityIndicatorView!
    
    
    //========================================
    //MARK: - Search Bar Delegate Methods
    //========================================
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
        self.loadingView.isHidden = false
        self.loadingActivityIndicator.startAnimating()
        
        self.searchItemImages.removeAll()
        self.searchItems.removeAll()
        
        let searchTerm =  ("\(searchBar.text ?? "")").replacingOccurrences(of: " ", with: "%20")
        
        var count = 0
        for i in 1...3 {
            let urlString = "\(NetworkController.omdbURLString)&page=\(i)&s=\(searchTerm)"
            guard let url = URL(string: urlString) else { return }
            
            NetworkController.performNetworkRequest(for: url, accessToken: nil) { (data, error) in
                let decoder = JSONDecoder()
                
                if let data = data,
                    let searchItems = try? decoder.decode(SearchItems.self, from: data) {
                    var unwrappedSearchItems = searchItems.Search
                    
                    for i in 0...unwrappedSearchItems.count - 1 {
                        if unwrappedSearchItems[i].moviePosterImageURL != nil {
                            NetworkController.performNetworkRequest(for: unwrappedSearchItems[i].moviePosterImageURL!, accessToken: nil, completion: { (data, error) in
                                
                                if let data = data, let image = UIImage(data: data) {
                                    self.searchItems.append(unwrappedSearchItems[i])
                                    self.searchItemImages.append(image)
                                }
                                
                                if count == 3 {
                                    while(self.searchItems.count > 25) {
                                        self.searchItems.removeLast()
                                        self.searchItemImages.removeLast()
                                    }
                                    DispatchQueue.main.async {
                                        self.tableView.reloadData()
                                        self.loadingView.isHidden = true
                                        self.loadingActivityIndicator.stopAnimating()
                                    }
                                }
                            })
                        }
                    }
                    
                }
                count += 1
            }
        }
        
    }
    
    //========================================
    //MARK: - Favorite Button Delegate Methods
    //========================================
    
    func favoriteButtonTapped(sender: UIButton) {
        sender.isSelected = !sender.isSelected
        
        if sender.isSelected {
            guard let currentMovieCell = sender.superview?.superview as? MovieTableViewCell else { return }
            for i in 0...tableView.visibleCells.count - 1 {
                if currentMovieCell.titleLabel.text == searchItems[i].title {
                    MovieController.shared.favorites.append(searchItems[i])
                    MovieController.shared.favoriteImages.append(searchItemImages[i])
                }
            }
        } else {
            guard let currentMovieCell = sender.superview?.superview as? MovieTableViewCell else { return }
            for i in 0...tableView.visibleCells.count - 1 {
                if currentMovieCell.titleLabel.text == searchItems[i].title {
                    MovieController.shared.favorites.remove(at: i)
                    MovieController.shared.favoriteImages.remove(at: i)
                }
            }
        }
    }
    
    //========================================
    //MARK: - Table View Data and Delegate Methods
    //========================================
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return searchItems.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "searchCell", for: indexPath) as! MovieTableViewCell
        let currentSearchItem = searchItems[indexPath.row]
        
        cell.titleLabel.text = currentSearchItem.title
        cell.yearLabel.text = currentSearchItem.year
        
        cell.posterImageView.image = searchItemImages[indexPath.row]
        
        cell.delegate = self
        
        return cell
    }
    
    //========================================
    //MARK: - Life Cycle Methods
    //========================================

    override func viewDidLoad() {
        super.viewDidLoad()
        
        loadingActivityIndicator.color = UIColor.gray
    }
}
