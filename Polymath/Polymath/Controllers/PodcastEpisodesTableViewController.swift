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
    
    static let cellIdentifier: String = "EpisodeTableViewCell"

    override func viewDidLoad() {
        super.viewDidLoad()
        
        configure()
    }
    
}

// MARK: - Configuration Functions
extension PodcastEpisodesTableViewController {
    
    private func configure() {
        navigationItem.title = self.podcast?.trackName ?? "N/A"
        
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: Self.cellIdentifier)
        //tableView.tableHeaderView = UIView(frame: CGRect(origin: .zero, size: .init(width: 200, height: 400)))
        
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
            let episode = Episode(feed: rssFeedItem, artistName: self.podcast?.artistName ?? "N/A")
            episodes.append(episode)
        }
        
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
    
}

// MARK: - TableVIew Functions
extension PodcastEpisodesTableViewController {
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        self.episodes.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: Self.cellIdentifier, for: indexPath)
        let episode = episodes[indexPath.row]
        
        cell.textLabel?.text = episode.title
        
        return cell
    }
    
}
