//
//  RMCharacterPhotoCollectionViewCellViewModel.swift
//  RickAndMorty
//
//  Created by Easin Md. Hosen on 15/1/24.
//

import Foundation
final class RMCharacterPhotoCollectionViewCellViewModel{
    private let imageUrl: URL?
    
    init(imageUrl: URL?) {
        self.imageUrl = imageUrl
    }
    
    public func fetchImage(completion: @escaping (Result<Data, Error>) -> Void){
        guard let imageUrl = imageUrl else{
            completion(.failure(URLError(.badURL)))
            return
        }
        RMImageLoader.shared.downlaodImage(imageUrl, completion: completion)
    }
    
}
