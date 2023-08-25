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
}

extension Podcast {
    
    static var podcasts: [Podcast] {
        [
            Podcast(trackName: "HazCast", artistName: "Hazem El Seddiq"),
            Podcast(trackName: "Droos Podcast", artistName: "Ahmed Abouzaid")
        ]
    }
    
}
