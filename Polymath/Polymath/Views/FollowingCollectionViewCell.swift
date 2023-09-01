//
//  FollowingCollectionViewCell.swift
//  Polymath
//
//  Created by Baher Tamer on 01/09/2023.
//

import UIKit

class FollowingCollectionViewCell: UICollectionViewCell {
    
    let podcastImageView = UIImageView()
    let podcastLabel = UILabel()
    let artistNameLabel = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        configureComponentsView()
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
}

// MARK: - UI Components Configurations
extension FollowingCollectionViewCell {
    
    private func configureComponentsView() {
        configurePodcastLabel()
        configureArtistNameLabel()
        configurePodcastImageView()
        configureVStack()
    }
    
    private func configurePodcastLabel() {
        self.podcastLabel.text = "Podcast Name"
        self.podcastLabel.font = UIFont.preferredFont(forTextStyle: .headline)
        self.podcastLabel.numberOfLines = 1
    }
    
    private func configureArtistNameLabel() {
        self.artistNameLabel.text = "Artist Name"
        self.artistNameLabel.font = UIFont.preferredFont(forTextStyle: .subheadline)
        self.artistNameLabel.textColor = .secondaryLabel
        self.artistNameLabel.numberOfLines = 1
    }
    
    private func configurePodcastImageView() {
        self.podcastImageView.backgroundColor = .systemGray6
        self.podcastImageView.layer.cornerRadius = 8
        
        let podcastImageViewConstraints = [
            self.podcastImageView.heightAnchor.constraint(equalTo: self.podcastImageView.widthAnchor)
        ]
        
        NSLayoutConstraint.activate(podcastImageViewConstraints)
    }
    
    private func configureVStack() {
        let stackView = UIStackView(arrangedSubviews: [
            self.podcastImageView,
            self.podcastLabel,
            self.artistNameLabel
        ])
        
        stackView.axis = .vertical
        stackView.alignment = .leading
        stackView.setCustomSpacing(8, after: self.podcastImageView)
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        self.addSubview(stackView)
        
        let stackViewConstraints = [
            stackView.topAnchor.constraint(equalTo: topAnchor),
            stackView.leadingAnchor.constraint(equalTo: leadingAnchor),
            stackView.bottomAnchor.constraint(equalTo: bottomAnchor),
            stackView.trailingAnchor.constraint(equalTo: trailingAnchor)
        ]
        
        NSLayoutConstraint.activate(stackViewConstraints)
    }
    
}
