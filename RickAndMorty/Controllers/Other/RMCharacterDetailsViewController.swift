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
    
    private let detailView: RmCharacterDetailsView
    
    // MARK: - Init
    
    init(viewModel: RMCharacterDetailsViewViewModel){
        self.viewModel = viewModel
        self.detailView = RmCharacterDetailsView(frame: .zero, viewModel: viewModel)
        super.init(nibName: nil,bundle: nil)
    }
    
    required init?(coder: NSCoder){
        fatalError("Unsupported")
    }
    // MARK - lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        title = viewModel.title
        view.addSubview(detailView)
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .action, target: self, action: #selector(didTapShare))
        addConstraints()
        detailView.collectionView?.delegate = self
        detailView.collectionView?.dataSource = self
        
//        viewModel.fetchCharacterData()
    }
    
    private func addConstraints(){
        NSLayoutConstraint.activate([
           detailView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
           detailView.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor),
           detailView.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor),
           detailView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
    
    @objc
    private func didTapShare(){
        // share character info
    }
}

// MARK: - CollectionView
extension RMCharacterDetailsViewController: UICollectionViewDelegate, UICollectionViewDataSource{
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return viewModel.sections.count
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch section {
        case 0:
            return 1
        case 1:
            return 8
        case 2:
            return 20
        default:
            return 1
        }
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath)
        if indexPath.section == 0 {
            cell.backgroundColor = .systemPink
        }
        else if indexPath.section == 1 {
            cell.backgroundColor = .systemGreen
        }else{
            cell.backgroundColor = .systemBlue
        }
        return cell
    }
}
