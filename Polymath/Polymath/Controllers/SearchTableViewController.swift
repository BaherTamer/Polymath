//
//  SearchTableViewController.swift
//  Polymath
//
//  Created by Baher Tamer on 24/08/2023.
//

import UIKit

class SearchTableViewController: UITableViewController {
    
    private let searchItemCellId = "SearchItemTableViewCell"
    
    private var podcasts: [Podcast] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.setupTableViewCell()
        self.setupSearchBar()
    }

}

// MARK: - UITableView Functions
extension SearchTableViewController {
    
    private func setupTableViewCell() {
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: self.searchItemCellId)
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        self.podcasts.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let podcast = self.podcasts[indexPath.row]
        
        let cell = tableView.dequeueReusableCell(withIdentifier: searchItemCellId, for: indexPath)
        cell.textLabel?.text = "\(podcast.trackName ?? "N/A")\n\(podcast.artistName ?? "N/A")"
        cell.textLabel?.numberOfLines = -1
        
        return cell
    }
    
}

// MARK: - Search Bar Functions
extension SearchTableViewController: UISearchBarDelegate {
    
    private func setupSearchBar() {
        let searchController = UISearchController(searchResultsController: nil)
        
        navigationItem.searchController = searchController
        navigationItem.hidesSearchBarWhenScrolling = false
        
        searchController.searchBar.delegate = self
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        
        APIManager.shared.fetchPodcasts(from: searchText) { fetchedPodcasts in
            self.podcasts = fetchedPodcasts
            self.tableView.reloadData()
        }
        
    }
    
}
