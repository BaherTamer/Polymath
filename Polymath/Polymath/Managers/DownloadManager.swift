//
//  DownloadManager.swift
//  Polymath
//
//  Created by Baher Tamer on 02/09/2023.
//

import Alamofire
import Foundation

struct DownloadManager {
    
    static private let downloadingEpisodeKey = "downloadingEpisodeKey"
    static private var episodes: [Episode] = []
    
    static func fetchDownloadedEpisodes() -> [Episode] {
        do {
            if let data = UserDefaults.standard.data(forKey: Self.downloadingEpisodeKey) {
                return try JSONDecoder().decode([Episode].self, from: data)
            }
        } catch {
            print("DEBUG: Failed to fetch downloaded episodes,", error)
            return []
        }
        
        return []
    }
    
    static func downloadEpisode(_ episode: Episode) {
        Self.episodes = Self.fetchDownloadedEpisodes()
        
        do {
            Self.episodes.insert(episode, at: 0)
            Self.saveEpisodeOffline(episode)
            try Self.saveDownloadedEpisodes()
        } catch {
            print("DEBUG: Failed to save downloaded episodes,", error)
        }
    }
    
    static private func saveEpisodeOffline(_ episode: Episode) {
        let downloadRequest = DownloadRequest.suggestedDownloadDestination()
        
        AF.download(episode.streamURL, to: downloadRequest).response { respone in
            guard let index = Self.episodes.firstIndex(where: { $0.title == episode.title }) else { return }
            
            Self.episodes[index].offlineURL = respone.fileURL?.absoluteString ?? ""
            print("Downloaded Success,", respone.fileURL?.absoluteString ?? "")
        }
    }
    
    static func isEpisodeDownloaded(_ episode: Episode) -> Bool {
        Self.episodes = Self.fetchDownloadedEpisodes()
        return Self.episodes.contains(where: { $0.title == episode.title })
    }
    
    static private func saveDownloadedEpisodes() throws {
        do {
            let data = try JSONEncoder().encode(Self.episodes)
            UserDefaults.standard.set(data, forKey: Self.downloadingEpisodeKey)
        } catch {
            throw error
        }
    }
    
    static func removeDownloadedEpisode(_ episode: Episode) {
        guard Self.isEpisodeDownloaded(episode) else {
            print("DEBUG: Episode was not found")
            return
        }
        
        guard let index = Self.episodes.firstIndex(where: { $0.title == episode.title }) else {
            print("DEBUG: Index was not found")
            return
        }
        
        Self.episodes.remove(at: index)
        
        do {
            try Self.saveDownloadedEpisodes()
        } catch {
            print("DEBUG: Failed to remove downloaded episodes,", error)
        }
    }
    
}
