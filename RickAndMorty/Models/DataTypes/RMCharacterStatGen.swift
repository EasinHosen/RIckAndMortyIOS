//
//  RMCharacterStatGen.swift
//  RickAndMorty
//
//  Created by Easin Md. Hosen on 4/12/23.
//

import Foundation
///for character status and gender

enum RMCharacterStatGen: String, Codable{
///('Female', 'Male', 'Genderless' or 'unknown')
    case male = "Male"
    case female = "Female"
    case genderless = "Genderless"
    case `unknown` = "unknown"
    
///('Alive', 'Dead').
    case alive = "Alive"
    case dead = "Dead"
    
    var text: String {
        switch self{
        case .alive, .dead, .male, .female, .genderless:
            return rawValue
        case .unknown:
            return "Unknown"
        }
    }
}
