//
//
//  RMCharacterViewController.swift
//  RickAndMorty
//
//  Created by Easin Md. Hosen on 3/12/23.
//

import UIKit

final class RMCharacterViewController: UIViewController, RMCharacterListViewDelegate {

    private let charListView = RMCharacterListView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        title = "Characters"
        setupView()
        addSearchButton()
    }
    
    private func addSearchButton(){
        navigationItem.rightBarButtonItem = UIBarButtonItem(
            barButtonSystemItem: .search,
            target: self,
            action: #selector(didTapSearch)
        )
    }
    
    @objc
    func didTapSearch(){
        let vc = RMSearchViewController(config: RMSearchViewController.Config(type: .character))
        vc.navigationItem.largeTitleDisplayMode = .never
        navigationController?.pushViewController(vc, animated: true)
    }
    
    private func setupView(){
        charListView.delegate = self
        view.addSubview(charListView)
        NSLayoutConstraint.activate([
            charListView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            charListView.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor),
            charListView.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor),
            charListView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
    
    //MARK: - RMCharacterListViewDelegate implementation
    func rmCharacterListView(_ characterListView: RMCharacterListView, didSelectCharacter character: RMCharacter) {
        //open details controller
        let viewModel = RMCharacterDetailsViewViewModel(character: character)
        let detaiVC = RMCharacterDetailsViewController(viewModel: viewModel)
        detaiVC.navigationItem.largeTitleDisplayMode = .never
        navigationController?.pushViewController(detaiVC, animated: true)
    }

}
