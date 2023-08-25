//
//  iTunesService.swift
//  Polymath
//
//  Created by Baher Tamer on 25/08/2023.
//

import Foundation

struct iTunesService {
    
    static let searchURL: String = "https://itunes.apple.com/search"
    
}

extension iTunesService {
    
    enum URLParameter: String {
        case term, media
    }
    
}
