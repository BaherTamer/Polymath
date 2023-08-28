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
        guard let url = getEpisodesURL() else { return }
        
        let parser = FeedParser(URL: url)
        parser.parseAsync { result in
            switch result {
            case let .success(feed):
                self.appendRSSFeedToEpisodes(feed: feed)
                break
            case let .failure(error):
                print("DEBUG: Failed to parse podcast episodes feed,", error)
                break
            }
        }
    }
    
    private func getEpisodesURL() -> URL? {
        guard let feedURL = self.podcast?.feedUrl else { return nil }
        
        let httpsFeedURL = feedURL.contains("https") ? feedURL : feedURL.replacingOccurrences(of: "http", with: "https")
        
        return URL(string: httpsFeedURL)
    }
    
    private func appendRSSFeedToEpisodes(feed: Feed) {
        feed.rssFeed?.items?.forEach { rssFeedItem in
            
            guard let podcast else { return }
            let episode = Episode(feed: rssFeedItem, podcast: podcast)
            episodes.append(episode)
        }
        
        DispatchQueue.main.async {
            self.tableView.reloadData()
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
