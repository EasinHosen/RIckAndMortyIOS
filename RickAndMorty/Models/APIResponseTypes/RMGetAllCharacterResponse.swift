//
//  RMGetAllCharacterResponse.swift
//  RickAndMorty
//
//  Created by Easin Md. Hosen on 5/12/23.
//

import Foundation

// MARK: - RMGetAllCharacterResponse
struct RMGetAllCharacterResponse: Codable {
    let info: Info
    let results: [RMCharacter]
}

// MARK: - Info
struct Info: Codable {
    let count, pages: Int
    let next: String?
    let prev: String?
}

//// MARK: - Encode/decode helpers
//
//class JSONNull: Codable, Hashable {
//    
//    public static func == (lhs: JSONNull, rhs: JSONNull) -> Bool {
//        return true
//    }
//    
//    public var hashValue: Int {
//        return 0
//    }
//    
//    public init() {}
//    
//    public required init(from decoder: Decoder) throws {
//        let container = try decoder.singleValueContainer()
//        if !container.decodeNil() {
//            throw DecodingError.typeMismatch(JSONNull.self, DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Wrong type for JSONNull"))
//        }
//    }
//    
//    public func encode(to encoder: Encoder) throws {
//        var container = encoder.singleValueContainer()
//        try container.encodeNil()
//    }
//}
