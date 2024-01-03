//
//  RMCharacterLVVIewModel.swift
//  RickAndMorty
//
//  Created by Easin Md. Hosen on 5/12/23.
//

import UIKit

protocol RMCharacterLVViewModelDelegate: AnyObject{
    func didLoadInitialCharacter()
    func didLoadMoreCharacters(with newIndexPaths: [IndexPath])
    
    func didSelectCharacter(_ character: RMCharacter)
}

//viewmodel to handle lv logic

class RMCharacterLVVIewModel: NSObject{
    public weak var delegate: RMCharacterLVViewModelDelegate?
    
    private var isLoadingMoreCharacters = false
    
    private var characters: [RMCharacter] = []{
        didSet{
            for char in characters{
                let m = RMCharacterCollectionViewCellVewModel(
                    characterName: char.name,
                    characterStatus: char.status,
                    characterImageUrl: URL(string: char.image)
                )
                if !cellViewModels.contains(m){
                    cellViewModels.append(m)
                }
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
    public func fetchAdditionalCharacters(url: URL){
        guard !isLoadingMoreCharacters else{
            return
        }
        isLoadingMoreCharacters = true
//        print("loading more")
//        isLoadingMoreCharacters = false
        guard let req = RMRequest(url: url) else{
            isLoadingMoreCharacters = false
//            print("Failed to create req")
            return
        }
        
        RMService.shared.execute(req, expecting: RMGetAllCharacterResponse.self){
            [weak self] result in
            guard let strongSelf = self else{
                return
            }
            switch result{
            case .success(let responseModel):
                let moreResults = responseModel.results
                strongSelf.apiInfo = responseModel.info
            
                let originalCount = strongSelf.characters.count
                let newCount = moreResults.count
                
                let total = originalCount+newCount
                
                let startingIndex = total - newCount
                
                let indexPathsToAdd: [IndexPath] = Array(startingIndex..<(startingIndex+newCount)).compactMap ({
                    return IndexPath(row: $0, section: 0)
                    
                })
                
                strongSelf.characters.append(contentsOf: moreResults)
                
                DispatchQueue.main.async{
                    strongSelf.delegate?.didLoadMoreCharacters(
                        with: indexPathsToAdd)
                    strongSelf.isLoadingMoreCharacters = false
                }
            case .failure(let failure):
                print(String(describing: failure))
                self?.isLoadingMoreCharacters = false
            }
        }
        
    }
    public var shouldShowLoadMoreIndecator: Bool{
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
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        guard kind == UICollectionView.elementKindSectionFooter,
              let footer = collectionView.dequeueReusableSupplementaryView(
            ofKind: kind,
            withReuseIdentifier:RMFooterLoadingCollectionReusableView.identifier,
            for: indexPath) as? RMFooterLoadingCollectionReusableView  else{
            fatalError("Unsupported")
        }
        footer.startAnimating()
        
        return footer
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForFooterInSection section: Int) -> CGSize {
        guard shouldShowLoadMoreIndecator else{
            return .zero
        }
        return CGSize(
            width: collectionView.frame.width,
            height: 100)
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
        guard shouldShowLoadMoreIndecator,
        !isLoadingMoreCharacters,
        !cellViewModels.isEmpty,
        let nextUrl = apiInfo?.next,
        let url = URL(string: nextUrl)
        else {
            return
        }
        Timer.scheduledTimer(withTimeInterval: 0.2, repeats: false){
            [weak self] t in
            let offset = scrollView.contentOffset.y
            let totalContentHeight = scrollView.contentSize.height
            let totalScrollViewHeight = scrollView.frame.size.height
            
            if offset >= (totalContentHeight - totalScrollViewHeight - 120){
                self?.fetchAdditionalCharacters(url: url)
            }
            t.invalidate()
        }
    }
}
 
