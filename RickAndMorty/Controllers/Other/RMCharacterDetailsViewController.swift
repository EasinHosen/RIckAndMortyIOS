//
//  RMCharacterDetailsViewController.swift
//  RickAndMorty
//
//  Created by Easin Md. Hosen on 18/12/23.
//

import UIKit

// controller for character details
class RMCharacterDetailsViewController: UIViewController {
    private let viewModel: RMCharacterDetailsViewViewModel
    
    init(viewModel: RMCharacterDetailsViewViewModel){
        self.viewModel = viewModel
        super.init(nibName: nil,
                   bundle: nil)
    }
    
    required init?(coder: NSCoder){
        fatalError("Unsupported")
    }
    // MARK - lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        title = viewModel.title
    }
    


}
