//
//  RMCharacterCollectionViewCellVewModel.swift
//  RickAndMorty
//
//  Created by Easin Md. Hosen on 5/12/23.
//

import Foundation
final class RMCharacterCollectionViewCellVewModel: Hashable, Equatable{
    public let characterName: String
    private let characterStatus: RMCharacterStatGen
    private let characterImageUrl: URL?

    init(
        characterName: String,
        characterStatus: RMCharacterStatGen,
        characterImageUrl: URL?
    ){
        self.characterName = characterName
        self.characterStatus = characterStatus
        self.characterImageUrl = characterImageUrl
    }
    
    public var characterStatusText: String{
        return "Status: \(characterStatus.text)"
    }
    
    public func fetchImage(completion: @escaping (Result<Data, Error>)->Void){
        guard let url = characterImageUrl else{
            completion(.failure(URLError(.badURL)))
            return}
        RMImageLoader.shared.downlaodImage(url, completion: completion)
        
    }
    
    //MARK:- hashable
    
    static func == (lhs: RMCharacterCollectionViewCellVewModel, rhs: RMCharacterCollectionViewCellVewModel) -> Bool{
        return lhs.hashValue == rhs.hashValue
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(characterName)
        hasher.combine(characterStatus)
        hasher.combine(characterImageUrl)
    }
}
