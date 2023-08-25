//
//  APIManager.swift
//  Polymath
//
//  Created by Baher Tamer on 25/08/2023.
//

import Alamofire
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
