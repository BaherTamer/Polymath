//
//  Podcast.swift
//  Polymath
//
//  Created by Baher Tamer on 24/08/2023.
//

import Foundation

struct Podcast {
    let name: String
    let author: String
}

extension Podcast {
    
    static var podcasts: [Podcast] {
        [
            Podcast(name: "HazCast", author: "Hazem El Seddiq"),
            Podcast(name: "Droos Podcast", author: "Ahmed Abouzaid")
        ]
    }
    
}
