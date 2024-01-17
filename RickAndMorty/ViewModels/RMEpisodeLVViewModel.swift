//
//  RMEpisodeLVViewModel.swift
//  RickAndMorty
//
//  Created by Easin Md. Hosen on 16/1/24.
//

import UIKit

protocol RMEpisodeLVViewModelDelegate: AnyObject{
    func didLoadInitialEpisode()
    func didLoadMoreEpisodes(with newIndexPaths: [IndexPath])
    
    func didSelectEpisode(_ episode: RMEpisode)
}

//viewmodel to handle lv logic

class RMEpisodeLVVIewModel: NSObject{
    public weak var delegate: RMEpisodeLVViewModelDelegate?
    
    private var isLoadingMoreEpisodes = false
    
    private var episodes: [RMEpisode] = []{
        didSet{
            for episode in episodes {
                let m = RMCharacterEpisodesCollectionViewCellViewModel(
                    episodeDataUrl: URL(string: episode.url)
                )
                if !cellViewModels.contains(m){
                    cellViewModels.append(m)
                }
            }
        }
    }
    
    private var cellViewModels: [RMCharacterEpisodesCollectionViewCellViewModel] = []
    
    private var apiInfo: RMGetAllEpisodesResponse.Info? = nil
    
    ///fetch initial set of episode(20)
    public func fetchEpisodes(){
        RMService.shared.execute(
            .listEpisodesRequest,
            expecting: RMGetAllEpisodesResponse.self){
            [weak self] result in
            switch result {
            case .success(let responseModel):
                let results = responseModel.results
                self?.apiInfo = responseModel.info
                self?.episodes = results
                DispatchQueue.main.async{
                    self?.delegate?.didLoadInitialEpisode()
                }
            case .failure(let error):
                print(String(describing: error))
            }
        }
    }
    
    /// load more episodes in the list
    public func fetchAdditionalEpisodes(url: URL){
        guard !isLoadingMoreEpisodes else{
            return
        }
        isLoadingMoreEpisodes = true
//        print("loading more")
//        isLoadingMoreEpisodes = false
        guard let req = RMRequest(url: url) else{
            isLoadingMoreEpisodes = false
//            print("Failed to create req")
            return
        }
        
        RMService.shared.execute(req, expecting: RMGetAllEpisodesResponse.self){
            [weak self] result in
            guard let strongSelf = self else{
                return
            }
            switch result{
            case .success(let responseModel):
                let moreResults = responseModel.results
                strongSelf.apiInfo = responseModel.info
            
                let originalCount = strongSelf.episodes.count
                let newCount = moreResults.count
                
                let total = originalCount+newCount
                
                let startingIndex = total - newCount
                
                let indexPathsToAdd: [IndexPath] = Array(startingIndex..<(startingIndex+newCount)).compactMap ({
                    return IndexPath(row: $0, section: 0)
                    
                })
                
                strongSelf.episodes.append(contentsOf: moreResults)
                
                DispatchQueue.main.async{
                    strongSelf.delegate?.didLoadMoreEpisodes(
                        with: indexPathsToAdd)
                    strongSelf.isLoadingMoreEpisodes = false
                }
            case .failure(let failure):
                print(String(describing: failure))
                self?.isLoadingMoreEpisodes = false
            }
        }
        
    }
    public var shouldShowLoadMoreIndecator: Bool{
        return apiInfo?.next != nil
    }
}


//MARK: - collection view
extension RMEpisodeLVVIewModel: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int)-> Int {
        return cellViewModels.count
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: RmCharacterEpisodeCollectionViewCell.cellIdentifier,
            for: indexPath) as? RmCharacterEpisodeCollectionViewCell else{
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
        
        return CGSize(
            width: width,
            height: width * 0.8
        )
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: true)
        let eps = episodes[indexPath.row]
        delegate?.didSelectEpisode(eps)
    }
}

//MARK: - scrollview
extension RMEpisodeLVVIewModel: UIScrollViewDelegate{
    func scrollViewDidScroll(_ scrollView: UIScrollView){
        guard shouldShowLoadMoreIndecator,
        !isLoadingMoreEpisodes,
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
                self?.fetchAdditionalEpisodes(url: url)
            }
            t.invalidate()
        }
    }
}
 
