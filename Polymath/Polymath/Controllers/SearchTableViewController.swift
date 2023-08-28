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
        self.tableView.separatorStyle = UITableViewCell.SeparatorStyle.none
        self.tableView.showsVerticalScrollIndicator = false
        
        tableView.register(
            UINib(nibName: PodcastSearchTableViewCell.cellIdentifier, bundle: nil),
            forCellReuseIdentifier: PodcastSearchTableViewCell.cellIdentifier
        )
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        self.podcasts.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(
            withIdentifier: PodcastSearchTableViewCell.cellIdentifier,
            for: indexPath) as! PodcastSearchTableViewCell
        
        let podcast = self.podcasts[indexPath.row]
        cell.configure(with: podcast)
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let podcastEpisodesVC = PodcastEpisodesTableViewController()
        let podcast = self.podcasts[indexPath.row]
        podcastEpisodesVC.podcast = podcast
        
        navigationController?.pushViewController(podcastEpisodesVC, animated: true)
    }
    
}

// MARK: - Search Bar Functions
extension SearchTableViewController: UISearchBarDelegate {
    
    private func setupSearchBar() {
        let searchController = UISearchController(searchResultsController: nil)
        
        self.definesPresentationContext = true
        
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
