//
//  RMEpisodeViewController.swift
//  RickAndMorty
//
//  Created by Easin Md. Hosen on 3/12/23.
//

import UIKit

final class RMEpisodeViewController: UIViewController, RMEpisodeListViewDelegate {

    private let episodeListView = RMEpisodeListView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        title = "Episode"
        setupView()
    }
    
    private func setupView(){
        episodeListView.delegate = self
        view.addSubview(episodeListView)
        NSLayoutConstraint.activate([
            episodeListView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            episodeListView.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor),
            episodeListView.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor),
            episodeListView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
    
    //MARK: - RMCharacterListViewDelegate implementation
    func rmEpisodeListView(_ episodeListView: RMEpisodeListView, didSelectEpisode episode: RMEpisode) {
        //open details controller
        let viewModel = RMEpisodeDetailViewViewModel(endpointUrl: URL(string: episode.url))
        let detaiVC = RMEpisodeDetailViewController(url: URL(string: episode.url))
        detaiVC.navigationItem.largeTitleDisplayMode = .never
        navigationController?.pushViewController(detaiVC, animated: true)
    }
    

}
