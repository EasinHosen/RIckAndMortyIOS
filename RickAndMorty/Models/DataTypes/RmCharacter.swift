//
//  RmCharacter.swift
//  RickAndMorty
//
//  Created by Easin Md. Hosen on 3/12/23.
//

import Foundation

struct RMCharacter: Codable {
    let id: Int
    let name, species, type: String
    let status: RMCharacterStatGen
    let gender: RMCharacterStatGen
    let origin, location: Origin
    let image: String
    let episode: [String]
    let url: String
    let created: String
}
