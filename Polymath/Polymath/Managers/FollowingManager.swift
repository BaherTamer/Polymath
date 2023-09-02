//
//  FollowingManager.swift
//  Polymath
//
//  Created by Baher Tamer on 02/09/2023.
//

import Foundation

struct FollowingManager {
    
    static private let followingPodcastsKey = "followingPodcastsKey"
    static private var podcasts: [Podcast] = []
    
    static func fetchFollowedPodcasts() -> [Podcast] {
        do {
            if let data = UserDefaults.standard.data(forKey: Self.followingPodcastsKey) {
                let fetchedPodcasts = try JSONDecoder().decode([Podcast].self, from: data)
                print("Fetched Success")
                print(fetchedPodcasts)
                print("\n")
                return fetchedPodcasts
            }
        } catch {
            print("Failed to fetch followed podcasts,", error)
            return []
        }
        
        return []
    }
    
    static func followPodcast(_ podcast: Podcast) {
        Self.podcasts = Self.fetchFollowedPodcasts()
        
        do {
            Self.podcasts.append(podcast)
            try Self.saveFollowedPodcasts()
            print("Saved sucess")
        } catch {
            print("Failed to save followed podcast,", error)
        }
    }
    
    static func isPodcastFollowed(_ podcast: Podcast) -> Bool {
        Self.podcasts = Self.fetchFollowedPodcasts()
        return Self.podcasts.contains(where: { $0.trackName == podcast.trackName })
    }
    
    static func saveFollowedPodcasts() throws {
        do {
            let data = try JSONEncoder().encode(Self.podcasts)
            UserDefaults.standard.set(data, forKey: Self.followingPodcastsKey)
        } catch {
            throw error
        }
    }
    
    static func unfollowPodcast(_ podcast: Podcast) {
        guard Self.isPodcastFollowed(podcast) else {
            print("Podcast was not found")
            return
        }
        
        guard let index = Self.podcasts.firstIndex(where: { $0.trackName == podcast.trackName }) else {
            print("Index was not found")
            return
        }
        
        Self.podcasts.remove(at: index)
        
        do {
            try Self.saveFollowedPodcasts()
            print(Self.podcasts)
        } catch {
            print("Failed to unfollow podcast,", error)
        }
    }
    
}
