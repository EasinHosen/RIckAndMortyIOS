//
//  RMCharacterLVVIewModel.swift
//  RickAndMorty
//
//  Created by Easin Md. Hosen on 5/12/23.
//

import UIKit

protocol RMCharacterLVViewModelDelegate: AnyObject{
    func didLoadInitialCharacter()
    func didSelectCharacter(_ character: RMCharacter)
}

//viewmodel to handle lv logic

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
    
    private var apiInfo: RMGetAllCharacterResponse.Info? = nil
    
    ///fetch initial set of char(20)
    public func fetchCharacters(){
        RMService.shared.execute(
            .listCharactersRequest,
            expecting: RMGetAllCharacterResponse.self){
            [weak self] result in
            switch result {
            case .success(let responseModel):
                let results = responseModel.results
                self?.apiInfo = responseModel.info
                self?.characters = results
                DispatchQueue.main.async{
                    self?.delegate?.didLoadInitialCharacter()
                }
            case .failure(let error):
                print(String(describing: error))
            }
        }
    }
    
    /// load more characters in the list
    public func fetchAdditionalCharacters(){
        
    }
    public var shouldSowLoaMoreIndecator: Bool{
        return apiInfo?.next != nil
    }
}


//MARK: - collection view
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
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: true)
        let char = characters[indexPath.row]
        delegate?.didSelectCharacter(char)
    }
}

//MARK: - scrollview
extension RMCharacterLVVIewModel: UIScrollViewDelegate{
    func scrollViewDidScroll(_ scrollView: UIScrollView){
        guard shouldSowLoaMoreIndecator else {
            return
        }
    }
}
