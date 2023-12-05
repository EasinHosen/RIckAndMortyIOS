//
//
//  RMCharacterViewController.swift
//  RickAndMorty
//
//  Created by Easin Md. Hosen on 3/12/23.
//

import UIKit

final class RMCharacterViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .systemBackground
        title = "Characters"
        // Do any additional setup after loading the view.
        
        let request = RMRequest(endpoint: .character, queryParameters: [
                URLQueryItem(name: "name", value: "rick"),
                URLQueryItem(name: "status", value: "alive"),
        ])
        print(request.url)
        
        RMService.shared.execute(request, expecting: RMCharacter.self){
            result in
        }
        
    }

}
