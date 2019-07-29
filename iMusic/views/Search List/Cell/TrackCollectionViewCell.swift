//
//  TrackCollectionViewCell.swift
//  iMusic
//
//  Created by Claudio Vega on 29/07/2019.
//  Copyright © 2019 Claudio Vega. All rights reserved.
//

import UIKit

class TrackCollectionViewCell: UICollectionViewCell {
    
    private let trackImageView: UIImageView = UIImageView()
    private let artistNameLabel: UILabel = UILabel()
    private let collectionNameLabel: UILabel = UILabel()
    private let trackNameLabel: UILabel = UILabel()
    private let releaseDateLabel: UILabel = UILabel()
    private let trackInformationLabel: UILabel = UILabel()
    private let genreLabel: UILabel = UILabel()
    
    //Identifier for reusable cells
    static public var identifier : String {
        return String(describing: self)
    }
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }
    
    public required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupViews()
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        trackImageView.image = nil
        artistNameLabel.text = ""
        collectionNameLabel.text = ""
        trackNameLabel.text = ""
        releaseDateLabel.text = ""
        trackInformationLabel.text = ""
        genreLabel.text = ""
    }
    
    static func getHeight(for width: CGFloat) -> CGFloat {
        return (width * Layout.ratio.height) / Layout.ratio.width
    }
    
    //Bind component
    public func bindWithViewModel(_ viewModel: TrackViewModel) {
        configureArtWorkWithUrl(viewModel.artworkUrl)
        artistNameLabel.text = viewModel.artistName
        collectionNameLabel.text = viewModel.collectionName
        trackNameLabel.text = viewModel.trackName
        releaseDateLabel.text = viewModel.releaseYear
        genreLabel.text = viewModel.primaryGenreName
        configureTrackInformationWith(viewModel)
    }
    
}

extension TrackCollectionViewCell {
    
    private func configureArtWorkWithUrl(_ url: URL?) {
        guard let url = url else {
            return
        }
        trackImageView.hnk_setImage(from: url, placeholder: nil)
    }
    
    private func configureTrackInformationWith(_ viewModel: TrackViewModel) {
        guard let price = viewModel.trackPrice else {
            trackInformationLabel.text = "\(viewModel.trackDuration)"
            return
        }
        
        trackInformationLabel.text = "\(viewModel.trackDuration) - \(price)"
    }
    
}

// MARK:- Layout & Constraints
extension TrackCollectionViewCell {
    
    //Private struct for internal layout
    private struct Layout {
        
        struct ratio {
            static let width: CGFloat = 100.0
            static let height: CGFloat = 175.0
        }
        
        struct ReleaseDateLabel {
            static let width: CGFloat = 40.0
            static let trailing: CGFloat = 5.0
            static let top: CGFloat = 5.0
            static let height: CGFloat = 16.0
        }
        
        struct ArtistNameLabel {
            static let top: CGFloat = 10.0
            static let height: CGFloat = 16.0
        }
        
        struct CollectionNameLabel {
            static let top: CGFloat = 5.0
            static let height: CGFloat = 16.0
        }
        
        struct TrackNameLabel {
            static let top: CGFloat = 5.0
            static let height: CGFloat = 16.0
        }
        
        struct TrackInformationLabel {
            static let top: CGFloat = 5.0
            static let height: CGFloat = 16.0
            static let bottom: CGFloat = 10.0
        }
        
        struct GenreLabel {
            static let top: CGFloat = 5.0
            static let height: CGFloat = 16.0
        }
        
    }
    
    //Common init method to setup all the components
    private func setupViews() {
        configureSubviews()
        addSubviews()
    }
    
    //Configure the elements inside the component
    private func configureSubviews() {
        backgroundColor = .clear
        
        trackImageView.frame = CGRect(x: 0.0, y: 0.0, width: 100.0, height: 100.0)
        trackImageView.backgroundColor = .clear
        trackImageView.contentMode = .scaleAspectFill
        trackImageView.layer.cornerRadius = 8.0
        trackImageView.clipsToBounds = true
        
        artistNameLabel.font = UIFont.mediumWithSize(size: 14.0)
        artistNameLabel.textColor = .white()
        
        collectionNameLabel.font = UIFont.mediumWithSize(size: 14.0)
        collectionNameLabel.textColor = .lightGray
        
        trackNameLabel.font = UIFont.mediumWithSize(size: 14.0)
        trackNameLabel.textColor = .white()
        
        releaseDateLabel.font = UIFont.mediumWithSize(size: 14.0)
        releaseDateLabel.textColor = .white()
        
        genreLabel.font = UIFont.mediumWithSize(size: 14.0)
        genreLabel.textColor = .white()
        genreLabel.textAlignment = .right
        
        trackInformationLabel.font = UIFont.mediumWithSize(size: 14.0)
        trackInformationLabel.textColor = .white()
    }
    
    // Add subviews
    private func addSubviews() {
        addSubview(trackImageView)
        addSubview(artistNameLabel)
        addSubview(collectionNameLabel)
        addSubview(trackNameLabel)
        addSubview(releaseDateLabel)
        addSubview(trackInformationLabel)
        addSubview(genreLabel)
        
        addConstraintsWithFormat("H:|[v0]|", views: trackImageView)
        addConstraintsWithFormat("V:|[v0]-\(Layout.ArtistNameLabel.top)-[v1]", views: trackImageView, artistNameLabel)
        
        addConstraintsWithFormat("H:|[v0]|", views: artistNameLabel)
        addConstraintsWithFormat("V:[v0(\(Layout.ArtistNameLabel.height))]-\(Layout.CollectionNameLabel.top)-[v1]", views: artistNameLabel, collectionNameLabel)
        
        addConstraintsWithFormat("H:|[v0]|", views: collectionNameLabel)
        addConstraintsWithFormat("V:[v0(\(Layout.CollectionNameLabel.height))]-\(Layout.TrackNameLabel.top)-[v1]", views: collectionNameLabel, trackNameLabel)
        
        addConstraintsWithFormat("H:|[v0]|", views: trackNameLabel)
        addConstraintsWithFormat("V:[v0(\(Layout.TrackNameLabel.height))]-\(Layout.ReleaseDateLabel.top)-[v1]", views: trackNameLabel, releaseDateLabel)
        
        addConstraintsWithFormat("H:|[v0(\(Layout.ReleaseDateLabel.width))]-\(Layout.ReleaseDateLabel.trailing)-[v1]|", views: releaseDateLabel, genreLabel)
        addConstraintsWithFormat("V:[v0(\(Layout.ReleaseDateLabel.height))]-\(Layout.TrackInformationLabel.top)-[v1]", views: releaseDateLabel, trackInformationLabel)
        
        addConstraintsWithFormat("V:[v0]-\(Layout.GenreLabel.top)-[v1(\(Layout.GenreLabel.height))]-\(Layout.TrackInformationLabel.top)-[v2]", views: trackNameLabel, genreLabel, trackInformationLabel)
        
        addConstraintsWithFormat("H:|[v0]|", views: trackInformationLabel)
        addConstraintsWithFormat("V:[v0(\(Layout.TrackInformationLabel.height))]-\(Layout.TrackInformationLabel.bottom)-|", views: trackInformationLabel)
    }
    
}


