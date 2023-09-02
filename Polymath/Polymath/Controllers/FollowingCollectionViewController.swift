//
//  FollowingCollectionViewController.swift
//  Polymath
//
//  Created by Baher Tamer on 01/09/2023.
//

import UIKit

private let reuseIdentifier = "FollowingCollectionViewCell"

class FollowingCollectionViewController: UICollectionViewController {
    
    var podcasts = FollowingManager.fetchFollowedPodcasts()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupCollectionView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.podcasts = FollowingManager.fetchFollowedPodcasts()
        collectionView.reloadData()
    }
    
    private func setupCollectionView() {
        self.collectionView!.register(FollowingCollectionViewCell.self, forCellWithReuseIdentifier: reuseIdentifier)
        self.collectionView.showsVerticalScrollIndicator = false
    }
    
}

// MARK: - UICollectionViewDataSource
extension FollowingCollectionViewController {
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        self.podcasts.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! FollowingCollectionViewCell
        
        cell.podcast = self.podcasts[indexPath.item]
        
        return cell
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let podcastEpisodesVC = PodcastEpisodesTableViewController()
        let podcast = self.podcasts[indexPath.item]
        podcastEpisodesVC.podcast = podcast
        
        navigationController?.pushViewController(podcastEpisodesVC, animated: true)
    }
    
}

// MARK: - UICollectionViewDelegateFlowLayout
extension FollowingCollectionViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        // 3 * 16 = Leading, Middle, and Trailing Space
        let sideSize = (view.frame.width - (3 * 16)) / 2
        return CGSize(width: sideSize, height: sideSize + 48)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        UIEdgeInsets(top: 16, left: 16, bottom: 16, right: 16)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        16
    }
    
}
