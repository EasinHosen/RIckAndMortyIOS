//
//  RmEpisode.swift
//  RickAndMorty
//
//  Created by Easin Md. Hosen on 3/12/23.
//

import Foundation
struct RMEpisode: Codable {
    let id: Int
    let name, airDate, episode: String
    let characters: [String]
    let url: String
    let created: String

    enum CodingKeys: String, CodingKey {
        case id, name
        case airDate = "air_date"
        case episode, characters, url, created
    }
}
