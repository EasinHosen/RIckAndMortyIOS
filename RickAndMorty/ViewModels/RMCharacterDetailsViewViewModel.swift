//
//  RMCharacterDetailsViewViewModel.swift
//  RickAndMorty
//
//  Created by Easin Md. Hosen on 18/12/23.
//

import UIKit

final class RMCharacterDetailsViewViewModel{
    private let character: RMCharacter
    
    enum SectionType: CaseIterable{
        case photo
        case information
        case episodes
    }
    
    public let sections = SectionType.allCases
    
    init(character: RMCharacter){
        self.character = character
    }
    
    public var requestUrl: URL? {
        return URL(string: character.url)
    }
    
    public var title: String{
        character.name.uppercased()
    }
    
    // the photo section in details page
    public func createPhotoSectionLayout()-> NSCollectionLayoutSection{
        let item = NSCollectionLayoutItem(
            layoutSize: NSCollectionLayoutSize(
                widthDimension: .fractionalWidth(1.0), heightDimension: .fractionalHeight(1.0)))
        item.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 0, bottom: 10, trailing: 0)
        let group = NSCollectionLayoutGroup.vertical(
            layoutSize: NSCollectionLayoutSize(
                widthDimension: .fractionalWidth(1.0),
                heightDimension: .fractionalHeight(0.5)),
            subitems: [item])
        
        let section = NSCollectionLayoutSection(group: group)
        
        return section
    }
    
    // the information section in details page
    public func createInfoSectionLayout()-> NSCollectionLayoutSection{
        let item = NSCollectionLayoutItem(
            layoutSize: NSCollectionLayoutSize(
                widthDimension: .fractionalWidth(0.5),
                heightDimension: .fractionalHeight(1.0)))
        item.contentInsets = NSDirectionalEdgeInsets(
            top: 2,
            leading: 2,
            bottom: 2,
            trailing: 2
        )
        let group = NSCollectionLayoutGroup.horizontal(
            layoutSize: NSCollectionLayoutSize(
                widthDimension: .fractionalWidth(1.0),
                heightDimension: .absolute(150)),
            subitems: [item, item]
        )
        
        let section = NSCollectionLayoutSection(group: group)
        
        return section
    }
    
    // the episodes section in details page
    public func createEpisodeSectionLayout()-> NSCollectionLayoutSection{
        let item = NSCollectionLayoutItem(
            layoutSize: NSCollectionLayoutSize(
                widthDimension: .fractionalWidth(1.0),
                heightDimension: .fractionalHeight(1.0)))
        item.contentInsets = NSDirectionalEdgeInsets(
            top: 10,
            leading: 10,
            bottom: 10,
            trailing: 0
        )
        let group = NSCollectionLayoutGroup.horizontal(
            layoutSize: NSCollectionLayoutSize(
                widthDimension: .fractionalWidth(0.8),
                heightDimension: .absolute(150)),
            subitems: [item])
        
        let section = NSCollectionLayoutSection(group: group)
        section.orthogonalScrollingBehavior = .groupPaging
        
        return section
    }
}
