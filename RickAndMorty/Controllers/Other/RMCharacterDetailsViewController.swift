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
        
        let sectionType = viewModel.sections[section]
        
        switch sectionType {
        case .photo:
            return 1
        case .information(viewModel: let viewModels):
            return viewModels.count
        case .episodes(viewModel: let episodes):
            return episodes.count
        }
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let sectionType = viewModel.sections[indexPath.section]
        
        switch sectionType {
        case .photo(let viewModel):
            guard let cell = collectionView.dequeueReusableCell(
                withReuseIdentifier: RMCharacterPhotoCollectionViewCell.cellIdentifier,
                for: indexPath) as? RMCharacterPhotoCollectionViewCell else{
                fatalError()
            }
            cell.configure(with: viewModel)
//            cell.backgroundColor = .systemYellow
            return cell
        case .information(let viewModels):
            guard let cell = collectionView.dequeueReusableCell(
                withReuseIdentifier: RMCharacterInfoCollectionViewCell.cellIdentifier,
                for: indexPath) as? RMCharacterInfoCollectionViewCell else{
                fatalError()
            }
            cell.configure(with: viewModels[indexPath.row])
//            cell.backgroundColor = .systemRed
            return cell
            
        case .episodes(let episodes):
            guard let cell = collectionView.dequeueReusableCell(
                withReuseIdentifier: RmCharacterEpisodeCollectionViewCell.cellIdentifier,
                for: indexPath) as? RmCharacterEpisodeCollectionViewCell else{
                fatalError()
            }
            cell.configure(with: episodes[indexPath.row])
//            cell.backgroundColor = .systemOrange
            return cell
        }
        
    }
}
