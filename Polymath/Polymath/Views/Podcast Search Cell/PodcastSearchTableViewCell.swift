//
//  PodcastSearchTableViewCell.swift
//  Polymath
//
//  Created by Baher Tamer on 25/08/2023.
//

import UIKit
import SDWebImage

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
        numberOfEpisodesLabel.text = "\(podcast.trackCount ?? 0) Episodes"
        
        guard let imageURL = URL(string: podcast.artworkUrl600 ?? "") else {
            print("DEBUG: Failed to load podcast image URL.")
            return
        }
        
        podcastImageView.sd_setImage(with: imageURL)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
