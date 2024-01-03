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
        let request = URLRequest(url: url)
        let task = URLSession.shared.dataTask(with: request){ data, _, error in
            guard let data = data, error == nil else{
                completion(.failure(error ?? URLError(.badServerResponse)))
                return
            }
            completion(.success(data))
        }
        task.resume()
        
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
