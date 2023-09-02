//
//  DownloadedTableViewController.swift
//  Polymath
//
//  Created by Baher Tamer on 02/09/2023.
//

import UIKit

class DownloadedTableViewController: UITableViewController {
    
    var episodes = DownloadManager.fetchDownloadedEpisodes()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        configure()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        episodes = DownloadManager.fetchDownloadedEpisodes()
        tableView.reloadData()
    }
    
}

// MARK: - Table view data source
extension DownloadedTableViewController {
    
    private func configure() {
        tableView.separatorStyle = UITableViewCell.SeparatorStyle.none
        tableView.showsVerticalScrollIndicator = false
        
        tableView.register(
            UINib(nibName: PodcastEpisodeTableViewCell.cellIdentifier, bundle: nil),
            forCellReuseIdentifier: PodcastEpisodeTableViewCell.cellIdentifier
        )
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
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        let episode = self.episodes[indexPath.row]
        self.episodes.remove(at: indexPath.row)
        tableView.deleteRows(at: [indexPath], with: .automatic)
        DownloadManager.removeDownloadedEpisode(episode)
    }
    
}
