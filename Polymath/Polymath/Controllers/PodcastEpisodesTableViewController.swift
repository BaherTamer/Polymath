//
//  PodcastEpisodesTableViewController.swift
//  Polymath
//
//  Created by Baher Tamer on 28/08/2023.
//

import FeedKit
import SDWebImage
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
        navigationItem.largeTitleDisplayMode = .never
        
        setupTableViewCell()
        setupTableHeaderView()
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
    }
    
    private func setupTableHeaderView() {
        let headerView = PodcastTableHeaderView(frame: CGRect(x: 0, y: 0, width: view.bounds.width, height: 350))
        
        guard let imageURL = URL(string: self.podcast?.artworkUrl600 ?? "") else {
            print("DEBUG: Failed to load podcast image URL.")
            return
        }
        
        headerView.podcastImageView.sd_setImage(with: imageURL)
        headerView.artistLabel.text = self.podcast?.artistName ?? "N/A"
        headerView.podcastLabel.text = self.podcast?.trackName ?? "N/A"
        
        headerView.followButton.setTitle(setFollowButtonTitle(), for: .normal)
        headerView.followButton.addTarget(self, action: #selector(followButtonPressed), for: .touchUpInside)
        
        tableView.tableHeaderView = headerView
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        self.episodes.count
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        "Episodes"
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(
            withIdentifier: PodcastEpisodeTableViewCell.cellIdentifier,
            for: indexPath) as! PodcastEpisodeTableViewCell
        
        cell.configure(with: self.episodes[indexPath.row])
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let episode = self.episodes[indexPath.row]
        
        let episodePlayerView = Bundle.main.loadNibNamed("EpisodePlayerView", owner: self)?.first as! EpisodePlayerView
        
        episodePlayerView.configure(episode: episode)
        episodePlayerView.frame = self.view.frame
        
        let viewController = UIViewController()
        viewController.view = episodePlayerView
        viewController.modalPresentationStyle = .fullScreen
        
        episodePlayerView.viewController = viewController
        present(viewController, animated: true)
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
}

extension PodcastEpisodesTableViewController {
    
    @objc func followButtonPressed(_ sender: UIButton) {
        guard let podcast = self.podcast else {
            return
        }
        
        if FollowManager.isPodcastFollowed(podcast) {
            FollowManager.unfollowPodcast(podcast)
            sender.setTitle("Follow", for: .normal)
        } else {
            FollowManager.followPodcast(podcast)
            sender.setTitle("Following", for: .normal)
        }
    }
    
    private func setFollowButtonTitle() -> String {
        guard let podcast = self.podcast else {
            return "Follow"
        }
        
        if FollowManager.isPodcastFollowed(podcast) {
            return "Following"
        } else {
            return "Follow"
        }
    }
    
}
