//
//  RMGetAllEpisodesResponse.swift
//  RickAndMorty
//
//  Created by Easin Md. Hosen on 17/1/24.
//

import Foundation

// MARK: - RMGetAllCharacterResponse
struct RMGetAllEpisodesResponse: Codable {
    let info: Info
    let results: [RMEpisode]
    
    // MARK: - Info
    struct Info: Codable {
        let count, pages: Int
        let next: String?
        let prev: String?
    }
}
