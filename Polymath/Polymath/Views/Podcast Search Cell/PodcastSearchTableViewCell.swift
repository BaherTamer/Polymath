//
//  PodcastSearchTableViewCell.swift
//  Polymath
//
//  Created by Baher Tamer on 25/08/2023.
//

import UIKit

class PodcastSearchTableViewCell: UITableViewCell {
    
    // MARK: - IBOutlets
    @IBOutlet weak var cellBackgroundView: UIView!
    @IBOutlet weak var podcastImageView: UIImageView!
    @IBOutlet weak var artistLabel: UILabel!
    @IBOutlet weak var trackLabel: UILabel!
    @IBOutlet weak var numberOfEpisodesLabel: UILabel!
    
    // MARK: - Constants
    static let cellIdentifier: String = "PodcastSearchTableViewCell"
    
    // MARK: - Functions
    override func awakeFromNib() {
        super.awakeFromNib()
        
        cellBackgroundView.layer.cornerRadius = 12
        podcastImageView.layer.cornerRadius = 8
    }
    
    func configure(with podcast: Podcast) {
        artistLabel.text = podcast.artistName
        trackLabel.text = podcast.trackName
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
