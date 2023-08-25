//
//  SearchResult.swift
//  Polymath
//
//  Created by Baher Tamer on 25/08/2023.
//

import Foundation

struct SearchResult: Decodable {
    let resultCount: Int
    let results: [Podcast]
}
