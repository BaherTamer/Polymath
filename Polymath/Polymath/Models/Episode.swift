//
//  Episode.swift
//  Polymath
//
//  Created by Baher Tamer on 28/08/2023.
//

import FeedKit
import Foundation

struct Episode {
    let title: String
    let artistName: String
    let pubDate: Date
    let duration: TimeInterval
}

extension Episode {
    init(feed: RSSFeedItem, artistName: String) {
        self.title = feed.title ?? "N/A"
        self.artistName = artistName
        self.pubDate = feed.pubDate ?? .now
        self.duration = feed.iTunes?.iTunesDuration ?? .zero
    }
}
