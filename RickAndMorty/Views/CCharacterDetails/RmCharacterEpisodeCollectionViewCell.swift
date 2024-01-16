//
//  RmCharacterEpisodesCollectionViewCell.swift
//  RickAndMorty
//
//  Created by Easin Md. Hosen on 15/1/24.
//

import UIKit

final class RmCharacterEpisodeCollectionViewCell: UICollectionViewCell {
    static let cellIdentifier = "RmCharacterEpisodesCollectionViewCell"
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.backgroundColor = .systemBlue
        contentView.layer.cornerRadius = 8
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    private func setUpConstraints(){}
    
    override func prepareForReuse() {
        super.prepareForReuse()
    }
    
    public func configure(with viewModel: RMCharacterEpisodesCollectionViewCellViewModel){
        viewModel.registerForData{ data in
            print(data.name)
            print(data.airDate)
            print(data.episode)
        }
        viewModel.fetchEpisode()
    }
}
