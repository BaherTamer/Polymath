//
//  PodcastTableHeaderView.swift
//  Polymath
//
//  Created by Baher Tamer on 29/08/2023.
//

import UIKit

class PodcastTableHeaderView: UIView {
    
    let podcastImageView: UIImageView = {
        let imageView = UIImageView()
        
        imageView.contentMode = .scaleToFill
        imageView.clipsToBounds = true
        imageView.backgroundColor = .systemGray6
        imageView.layer.cornerRadius = 8
        imageView.translatesAutoresizingMaskIntoConstraints = false
        
        return imageView
    }()
    
    let artistLabel: UILabel = {
        let label = UILabel()
        
        label.textAlignment = .center
        label.numberOfLines = 2
        label.font = UIFont.preferredFont(forTextStyle: .headline)
        label.textColor = .secondaryLabel
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    let podcastLabel: UILabel = {
        let label = UILabel()
        
        label.textAlignment = .center
        label.numberOfLines = 2
        label.font = UIFont.preferredFont(forTextStyle: .title1, compatibleWith: .init(legibilityWeight: .bold))
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    let followButton: UIButton = {
        let button = UIButton()
        
        button.titleLabel?.font = UIFont.preferredFont(forTextStyle: .headline)
        button.titleLabel?.textColor = .white
        button.backgroundColor = .systemPink
        button.layer.cornerRadius = 4
        button.translatesAutoresizingMaskIntoConstraints = false
        
        return button
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addSubview(podcastImageView)
        addSubview(followButton)
        addSubview(artistLabel)
        addSubview(podcastLabel)
        
        applyConstraints()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
    }
    
    private func applyConstraints() {
        
        let podcastImageConstraints = [
            podcastImageView.topAnchor.constraint(equalTo: topAnchor, constant: 16),
            podcastImageView.centerXAnchor.constraint(equalTo: centerXAnchor),
            podcastImageView.widthAnchor.constraint(equalToConstant: 150),
            podcastImageView.heightAnchor.constraint(equalToConstant: 150)
        ]
        
        let artistLabelConstraints = [
            artistLabel.topAnchor.constraint(equalTo: podcastImageView.bottomAnchor, constant: 24),
            artistLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
            artistLabel.widthAnchor.constraint(equalTo: widthAnchor, constant: -24)
        ]
        
        let podcastLabelConstraints = [
            podcastLabel.topAnchor.constraint(equalTo: artistLabel.bottomAnchor, constant: 8),
            podcastLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
            podcastLabel.widthAnchor.constraint(equalTo: widthAnchor, constant: -24)
        ]
        
        let followButtonConstraints = [
            followButton.topAnchor.constraint(equalTo: podcastLabel.bottomAnchor, constant: 24),
            followButton.centerXAnchor.constraint(equalTo: centerXAnchor),
            followButton.widthAnchor.constraint(equalToConstant: 150)
        ]
     
        NSLayoutConstraint.activate(podcastImageConstraints)
        NSLayoutConstraint.activate(artistLabelConstraints)
        NSLayoutConstraint.activate(podcastLabelConstraints)
        NSLayoutConstraint.activate(followButtonConstraints)
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
}
