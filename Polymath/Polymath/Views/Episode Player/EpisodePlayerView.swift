//
//  EpisodePlayerView.swift
//  Polymath
//
//  Created by Baher Tamer on 31/08/2023.
//

import SDWebImage
import UIKit

class EpisodePlayerView: UIView {
    
    @IBOutlet weak var backgroundImageView: UIImageView!
    @IBOutlet weak var podcastImageView: UIImageView!
    @IBOutlet weak var podcastLabel: UILabel!
    @IBOutlet weak var episodeLabel: UILabel!
    
    func configure(episode: Episode, podcast: Podcast) {
        podcastLabel.text = podcast.trackName ?? "N/A"
        episodeLabel.text = episode.title
        
        
        guard let imageURL = URL(string: podcast.artworkUrl600 ?? "") else {
            print("DEBUG: Failed to load podcast image URL.")
            return
        }
        
        podcastImageView.layer.cornerRadius = 12
        podcastImageView.sd_setImage(with: imageURL)
        
        
        let blurEffect = UIBlurEffect(style: UIBlurEffect.Style.systemThickMaterial)
        let blurEffectView = UIVisualEffectView(effect: blurEffect)
        blurEffectView.frame = self.bounds
        
        backgroundImageView.sd_setImage(with: imageURL)
        backgroundImageView.addSubview(blurEffectView)
    }
    
    @IBAction func dismissButtonPressed(_ sender: UIButton) {
        self.removeFromSuperview()
    }
    
    @IBAction func downloadButtonPressed(_ sender: UIButton) {
    }
    
    @IBAction func playButtonPressed(_ sender: UIButton) {
    }
    
    @IBAction func backwardButtonPressed(_ sender: UIButton) {
    }
    
    @IBAction func forwardButtonPressed(_ sender: UIButton) {
    }
    
}
