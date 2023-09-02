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
    
    weak var viewController: UIViewController!
    private var episode: Episode!
    
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
        self.episode = episode
        
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
        self.viewController.dismiss(animated: true)
    }
    
    @IBAction func downloadButtonPressed(_ sender: UIButton) {
        guard let episode = self.episode else { return }
        DownloadManager.downloadEpisode(episode)
    }
    
    @IBAction func playPauseButtonPressed(_ sender: UIButton) {
        handlePlayPause()
    }
    
    @IBAction func timeSliderChanged(_ sender: UISlider) {
        guard let duration = self.avPlayer.currentItem?.duration else { return }
        let sliderValue = sender.value
        
        let durationInSeconds = CMTimeGetSeconds(duration)
        let newTimeInSeconds = Float64(sliderValue) * durationInSeconds
        
        let newTime = CMTimeMakeWithSeconds(newTimeInSeconds, preferredTimescale: Int32(NSEC_PER_SEC))
        self.avPlayer.seek(to: newTime)
        self.avPlayer.play() // BUG: Player stops after slider changed
    }
    
    @IBAction func backwardButtonPressed(_ sender: UIButton) {
        let fifteenSeconds = CMTimeMakeWithSeconds(15, preferredTimescale: Int32(NSEC_PER_SEC))
        let newTime = CMTimeSubtract(self.avPlayer.currentTime(), fifteenSeconds)
        self.avPlayer.seek(to: newTime)
    }
    
    @IBAction func forwardButtonPressed(_ sender: UIButton) {
        let fifteenSeconds = CMTimeMakeWithSeconds(15, preferredTimescale: Int32(NSEC_PER_SEC))
        let newTime = CMTimeAdd(self.avPlayer.currentTime(), fifteenSeconds)
        self.avPlayer.seek(to: newTime)
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
        
        self.avPlayer.addPeriodicTimeObserver(forInterval: interval, queue: .main) { [weak self] currentTime in
            self?.currentTimeLabel.text = currentTime.toString()
            self?.totalTimeLabel.text = self?.avPlayer.currentItem?.duration.toString()
            self?.updatePlayerSlider()
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
