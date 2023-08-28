//
//  PodcastEpisodesTableViewController.swift
//  Polymath
//
//  Created by Baher Tamer on 28/08/2023.
//

import UIKit

class PodcastEpisodesTableViewController: UITableViewController {
    
    var podcast: Podcast?
    
    var episodes: [Episode] = [
        Episode(title: "Episode Number 1"),
        Episode(title: "Episode Number 2"),
        Episode(title: "Episode Number 3"),
        Episode(title: "Episode Number 4"),
        Episode(title: "Episode Number 5"),
        Episode(title: "Episode Number 6")
    ]
    
    static let cellIdentifier: String = "EpisodeTableViewCell"

    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.title = podcast?.trackName ?? "N/A"
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: Self.cellIdentifier)
        
        //tableView.tableHeaderView = UIView(frame: CGRect(origin: .zero, size: .init(width: 200, height: 400)))
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
