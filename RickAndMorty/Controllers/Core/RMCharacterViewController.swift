//
//
//  RMCharacterViewController.swift
//  RickAndMorty
//
//  Created by Easin Md. Hosen on 3/12/23.
//

import UIKit

final class RMCharacterViewController: UIViewController {

    private let charListView = CharacterListView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        title = "Characters"
        setupView()
    }
    
    private func setupView(){
        view.addSubview(charListView)
        NSLayoutConstraint.activate([
            charListView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            charListView.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor),
            charListView.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor),
            charListView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }

}
