//
//  RMEndpoint.swift
//  RickAndMorty
//
//  Created by Easin Md. Hosen on 4/12/23.
//

import Foundation

/// api endpoints
@frozen enum RMEndpoint: String, CaseIterable, Hashable{
    case character  //"character"
    case location
    case episode
    
}
