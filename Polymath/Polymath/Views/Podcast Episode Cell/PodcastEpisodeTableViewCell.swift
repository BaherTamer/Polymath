//
//  PodcastEpisodeTableViewCell.swift
//  Polymath
//
//  Created by Baher Tamer on 28/08/2023.
//

import SDWebImage
import UIKit

class PodcastEpisodeTableViewCell: UITableViewCell {
    
    // MARK: - IBOutlets
    @IBOutlet weak var cellBackgroundView: UIView!
    @IBOutlet weak var episodeImageView: UIImageView!
    @IBOutlet weak var artistNameLabel: UILabel!
    @IBOutlet weak var episodeTitleLabel: UILabel!
    @IBOutlet weak var episodeDurationLabel: UILabel!
    @IBOutlet weak var episodePubDateLabel: UILabel!
    
    // MARK: - Constants
    static let cellIdentifier: String = "PodcastEpisodeTableViewCell"
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        cellBackgroundView.layer.cornerRadius = 12
        episodeImageView.layer.cornerRadius = 8
    }
    
    func configure(with episode: Episode) {
        artistNameLabel.text = episode.artistName
        episodeTitleLabel.text = episode.title
        episodeDurationLabel.text = "\(Int(episode.duration) / 60) mins"
        episodePubDateLabel.text = episode.pubDate.formatted(date: .long, time: .omitted)
        
        guard let imageURL = URL(string: episode.artworkUrl600) else {
            print("DEBUG: Failed to load episode image URL.")
            return
        }

        episodeImageView.sd_setImage(with: imageURL)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
