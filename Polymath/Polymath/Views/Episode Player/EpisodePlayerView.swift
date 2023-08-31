//
//  EpisodePlayerView.swift
//  Polymath
//
//  Created by Baher Tamer on 31/08/2023.
//

import AVKit
import SDWebImage
import UIKit

class EpisodePlayerView: UIView {
    
    @IBOutlet weak var backgroundImageView: UIImageView!
    @IBOutlet weak var podcastImageView: UIImageView!
    @IBOutlet weak var podcastLabel: UILabel!
    @IBOutlet weak var episodeLabel: UILabel!
    @IBOutlet weak var currentTimeSlider: UISlider!
    @IBOutlet weak var currentTimeLabel: UILabel!
    @IBOutlet weak var totalTimeLabel: UILabel!
    @IBOutlet weak var playPauseButton: UIButton!
    
    let avPlayer: AVPlayer = {
        let player = AVPlayer()
        player.automaticallyWaitsToMinimizeStalling = false
        return player
    }()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        observeEpisodeCurrentTime()
    }
    
    func configure(episode: Episode) {
        podcastLabel.text = episode.trackName
        episodeLabel.text = episode.title
        
        
        guard let imageURL = URL(string: episode.artworkUrl600) else {
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
        
        self.playPauseButton.setImage(UIImage(systemName: "pause.circle"), for: .normal)
        playEpisode(episode)
    }
    
    @IBAction func dismissButtonPressed(_ sender: UIButton) {
        self.removeFromSuperview()
    }
    
    @IBAction func downloadButtonPressed(_ sender: UIButton) {
    }
    
    @IBAction func playPauseButtonPressed(_ sender: UIButton) {
        handlePlayPause()
    }
    
    @IBAction func backwardButtonPressed(_ sender: UIButton) {
    }
    
    @IBAction func forwardButtonPressed(_ sender: UIButton) {
    }
    
}

// MARK: - AVKit Player Functions
extension EpisodePlayerView {
    
    private func playEpisode(_ episode: Episode) {
        guard let streamURL = URL(string: episode.streamURL) else {
            print("DEBUG: Failed to load episode stream URL.")
            return
        }
        
        let playerItem = AVPlayerItem(url: streamURL)
        
        self.avPlayer.replaceCurrentItem(with: playerItem)
        self.avPlayer.play()
    }
    
    private func handlePlayPause() {
        if self.avPlayer.timeControlStatus == .playing {
            self.playPauseButton.setImage(UIImage(systemName: "play.circle"), for: .normal)
            self.avPlayer.pause()
        } else {
            self.playPauseButton.setImage(UIImage(systemName: "pause.circle"), for: .normal)
            self.avPlayer.play()
        }
    }
    
    private func observeEpisodeCurrentTime() {
        let interval = CMTimeMake(value: 1, timescale: 2)
        
        self.avPlayer.addPeriodicTimeObserver(forInterval: interval, queue: .main) { currentTime in
            self.currentTimeLabel.text = currentTime.toString()
            self.totalTimeLabel.text = self.avPlayer.currentItem?.duration.toString()
            self.updatePlayerSlider()
        }
    }
    
    private func updatePlayerSlider() {
        let currentTimeSeconds = CMTimeGetSeconds(self.avPlayer.currentTime( ))
        let durationSeconds = CMTimeGetSeconds(self.avPlayer.currentItem?.duration ??
        CMTimeMake(value: 0, timescale: 0))
        
        let percentage = currentTimeSeconds / durationSeconds
        self.currentTimeSlider.value = Float(percentage)
    }
}
