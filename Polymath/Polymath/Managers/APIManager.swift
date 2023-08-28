//
//  APIManager.swift
//  Polymath
//
//  Created by Baher Tamer on 25/08/2023.
//

import Alamofire
import FeedKit
import Foundation

class APIManager {
    
    // Singleton
    static let shared = APIManager()
    
}

// MARK: - Fetch Podcast Functions
extension APIManager {
    
    func fetchPodcasts(from searchText: String, completionHandler: @escaping ([Podcast]) -> ()) {
        let parameters = [
            iTunesService.URLParameter.term.rawValue.lowercased(): searchText,
            iTunesService.URLParameter.media.rawValue.lowercased(): "podcast"
        ]
        
        let request = AF.request(
            iTunesService.searchURL,
            method: .get,
            parameters: parameters,
            encoding: URLEncoding.default
        )
        
        request.response { returnedData in
            if let error = returnedData.error {
                print("DEBUG: Failed to fetch data, \(error)")
                return
            }
            
            guard let data = returnedData.data else {
                print("DEBUG: No data can be found")
                return
            }
            
            do {
                let searchResult = try JSONDecoder().decode(SearchResult.self, from: data)
                
                completionHandler(searchResult.results)
            } catch {
                print("DEBUG: Failed to decode data")
            }
        }
    }
    
}

extension APIManager {
    
    func fetchEpisodes(for podcast: Podcast, urlString: String, completionHandler: @escaping ([Episode]) -> ()) {
        guard let url = getEpisodesURL(from: urlString) else { return }
        
        let parser = FeedParser(URL: url)
        parser.parseAsync { result in
            switch result {
            case let .success(feed):
                completionHandler(self.appendRSSFeedToEpisodes(feed: feed, podcast: podcast))
                break
            case let .failure(error):
                print("DEBUG: Failed to parse podcast episodes feed,", error)
                break
            }
        }
    }
    
    private func getEpisodesURL(from string: String) -> URL? {
        let httpsFeedURL = string.contains("https") ? string : string.replacingOccurrences(of: "http", with: "https")
        
        return URL(string: httpsFeedURL)
    }
    
    private func appendRSSFeedToEpisodes(feed: Feed, podcast: Podcast) -> [Episode] {
        var episodes: [Episode] = []
        
        feed.rssFeed?.items?.forEach { rssFeedItem in
            let episode = Episode(feed: rssFeedItem, podcast: podcast)
            episodes.append(episode)
        }
        
        return episodes
    }
    
}
