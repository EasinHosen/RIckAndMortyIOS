//
//  RMLocation.swift
//  RickAndMorty
//
//  Created by Easin Md. Hosen on 3/12/23.
//

import Foundation

struct RMLocation: Codable {
    let id: Int
    let name, type, dimension: String
    let residents: [String]
    let url: String
    let created: String
}
