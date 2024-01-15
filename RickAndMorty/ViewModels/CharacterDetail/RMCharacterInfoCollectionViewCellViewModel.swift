//
//  RMCharacterInfoCollectionViewCellViewModel.swift
//  RickAndMorty
//
//  Created by Easin Md. Hosen on 15/1/24.
//

import Foundation
final class RMCharacterInfoCollectionViewCellViewModel{
    public let value: String
    public let title: String
    
    init(
        value: String,
        title: String
    ){
        self.value = value
        self.title = title
    }
}
