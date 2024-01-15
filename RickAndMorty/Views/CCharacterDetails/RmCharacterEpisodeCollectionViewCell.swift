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
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    private func setUpConstraints(){}
    
    override func prepareForReuse() {
        super.prepareForReuse()
    }
    
    public func configure(with viewModel: RMCharacterEpisodesCollectionViewCellViewModel){}
}
