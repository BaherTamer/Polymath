//
//  PodcastEpisodesTableViewController.swift
//  Polymath
//
//  Created by Baher Tamer on 28/08/2023.
//

import FeedKit
import UIKit

class PodcastEpisodesTableViewController: UITableViewController {
    
    var podcast: Podcast?
    
    var episodes: [Episode] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        
        configure()
    }
    
}

// MARK: - Configuration Functions
extension PodcastEpisodesTableViewController {
    
    private func configure() {
        navigationItem.title = self.podcast?.trackName ?? "N/A"
        
        setupTableViewCell()
        fetchEpisodes()
    }
    
    private func fetchEpisodes() {
        guard let podcast else { return }
        
        APIManager.shared.fetchEpisodes(for: podcast, urlString: podcast.feedUrl ?? "") { fetchedEpisodes in
            self.episodes = fetchedEpisodes
            
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
    
}

// MARK: - TableVIew Functions
extension PodcastEpisodesTableViewController {
    
    private func setupTableViewCell() {
        self.tableView.separatorStyle = UITableViewCell.SeparatorStyle.none
        self.tableView.showsVerticalScrollIndicator = false
        
        tableView.register(
            UINib(nibName: PodcastEpisodeTableViewCell.cellIdentifier, bundle: nil),
            forCellReuseIdentifier: PodcastEpisodeTableViewCell.cellIdentifier
        )
        
        //tableView.tableHeaderView = UIView(frame: CGRect(origin: .zero, size: .init(width: 200, height: 400)))
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        self.episodes.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(
            withIdentifier: PodcastEpisodeTableViewCell.cellIdentifier,
            for: indexPath) as! PodcastEpisodeTableViewCell
        
        cell.configure(with: self.episodes[indexPath.row])
        return cell
    }
    
}
