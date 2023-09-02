//
//  Episode.swift
//  Polymath
//
//  Created by Baher Tamer on 28/08/2023.
//

import FeedKit
import Foundation

struct Episode: Codable {
    let title: String
    let artistName: String
    let pubDate: Date
    let duration: TimeInterval
    
    let artworkUrl600: String
    let trackName: String
    let streamURL: String
    
    var offlineURL: String?
}

extension Episode {
    init(feed: RSSFeedItem, podcast: Podcast) {
        self.title = feed.title ?? "N/A"
        self.artistName = podcast.artistName ?? "N/A"
        self.pubDate = feed.pubDate ?? .now
        self.duration = feed.iTunes?.iTunesDuration ?? .zero
        self.artworkUrl600 = podcast.artworkUrl600 ?? ""
        self.trackName = podcast.trackName ?? "N/A"
        self.streamURL = feed.enclosure?.attributes?.url ?? ""
    }
}
