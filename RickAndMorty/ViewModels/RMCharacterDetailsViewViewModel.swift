//
//  RMCharacterDetailsViewViewModel.swift
//  RickAndMorty
//
//  Created by Easin Md. Hosen on 18/12/23.
//

import Foundation

final class RMCharacterDetailsViewViewModel{
    private let character: RMCharacter
    init(character: RMCharacter){
        self.character = character
    }
    
    public var title: String{
        character.name.uppercased()
    }
}
