//
//  Podcast.swift
//  Polymath
//
//  Created by Baher Tamer on 24/08/2023.
//

import Foundation

struct Podcast: Decodable {
    let trackName: String?
    let artistName: String?
    let artworkUrl600: String?
    let trackCount: Int?
    let feedUrl: String?
}
