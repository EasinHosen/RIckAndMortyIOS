//
//  RMEpisodeDetailViewViewModel.swift
//  RickAndMorty
//
//  Created by Easin Md. Hosen on 16/1/24.
//

import UIKit

class RMEpisodeDetailViewViewModel {
    private let endpointUrl: URL?
    
    init(endpointUrl: URL?) {
        self.endpointUrl = endpointUrl
        fetchEpisodeData()
    }
    
    private func fetchEpisodeData(){
        guard let url = endpointUrl,
        let request = RMRequest(url: url) else{
            return
        }
        RMService.shared.execute(
            request,
            expecting: RMEpisode.self) { result in
                switch result {
                case .success(let eps):
                    print(String(describing: eps))
                case .failure(let f):
                    break
                }
            }
    }
}
