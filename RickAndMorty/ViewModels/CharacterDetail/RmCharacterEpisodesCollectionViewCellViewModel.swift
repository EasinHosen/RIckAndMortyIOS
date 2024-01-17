//
//  RmCharacterEpisodesCollectionViewCellViewModel.swift
//  RickAndMorty
//
//  Created by Easin Md. Hosen on 15/1/24.
//

import Foundation

protocol RMEpisodeDataRender{
    var name: String{get}
    var airDate: String{get}
    var episode: String{get}
}

final class RMCharacterEpisodesCollectionViewCellViewModel: Hashable, Equatable{
    
    private let episodeDataUrl: URL?
    
    private var isFetching = false
    
    private var dataBlcok: ((RMEpisodeDataRender)-> Void)?
    
    private var episode: RMEpisode? {
        didSet{
            guard let model = episode else {
                return
            }
            dataBlcok?(model)
        }
    }
    
    //MARK: - Init
    init(episodeDataUrl: URL?){
        self.episodeDataUrl = episodeDataUrl
    }
    
    public func registerForData(_ block: @escaping(RMEpisodeDataRender)-> Void){
        self.dataBlcok = block
    }
    
    //fetch episode from api
    public func fetchEpisode(){
        guard !isFetching else{
            if let model = episode {
                self.dataBlcok?(model)
            }
            return
        }
        
        guard let url = episodeDataUrl,
              let request = RMRequest(url: url) else {
            return
        }
        
        isFetching = true
        
        RMService.shared.execute(request, expecting: RMEpisode.self){ [weak self] result in
            switch result{
            case .success(let eps):
                DispatchQueue.main.async {
                    self?.episode = eps
                }
            case .failure(let f):
                print(String(describing: f))
            }
        }
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(self.episodeDataUrl?.absoluteString ?? "")
    }
    
    static func == (lhs: RMCharacterEpisodesCollectionViewCellViewModel, rhs: RMCharacterEpisodesCollectionViewCellViewModel) -> Bool {
        return lhs.hashValue == rhs.hashValue
    }
}
