//
//  RMCharacterLVVIewModel.swift
//  RickAndMorty
//
//  Created by Easin Md. Hosen on 5/12/23.
//

import UIKit

protocol RMCharacterLVViewModelDelegate: AnyObject{
    func didLoadInitialCharacter()
}

class RMCharacterLVVIewModel: NSObject{
    public weak var delegate: RMCharacterLVViewModelDelegate?
    
    private var characters: [RMCharacter] = []{
        didSet{
            for char in characters{
                let m = RMCharacterCollectionViewCellVewModel(
                    characterName: char.name,
                    characterStatus: char.status,
                    characterImageUrl: URL(string: char.image)
                )
                cellViewModels.append(m)
            }
        }
    }
    
    private var cellViewModels: [RMCharacterCollectionViewCellVewModel] = []
    
    public func fetchCharacters(){
        RMService.shared.execute(
            .listCharactersRequest,
            expecting: RMGetAllCharacterResponse.self){
            [weak self] result in
            switch result {
            case .success(let responseModel):
                let results = responseModel.results
//                let info = responseModel.info
                self?.characters = results
                DispatchQueue.main.async{
                    self?.delegate?.didLoadInitialCharacter()
                }
            case .failure(let error):
                print(String(describing: error))
            }
        }
    }
}

extension RMCharacterLVVIewModel: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int)-> Int {
        return cellViewModels.count
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: RMCharacterCollectionViewCell.cellIdentifier,
            for: indexPath) as? RMCharacterCollectionViewCell else{
            fatalError("Unsupported cell")
        }
        let viewM = cellViewModels[indexPath.row]
        cell.configure(with: viewM)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let bounds = UIScreen.main.bounds
        let width = (bounds.width-30)/2
        
        return CGSize(width: width, height: width*1.5)
    }
}
