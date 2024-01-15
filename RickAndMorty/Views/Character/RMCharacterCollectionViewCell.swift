//
//  RMCharacterCollectionViewCell.swift
//  RickAndMorty
//
//  Created by Easin Md. Hosen on 5/12/23.
//

import UIKit

///cell for character
final class RMCharacterCollectionViewCell: UICollectionViewCell {
    static let cellIdentifier = "RMCharacterCollectionViewCell"
    
    private let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private let nameLabel: UILabel = {
        let nameLabel = UILabel()
        nameLabel.textColor = .secondaryLabel
        nameLabel.font = .systemFont(ofSize: 16, weight:  .regular)
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        return nameLabel
    }()
    
    private let statusLabel: UILabel = {
        let statusLabel = UILabel()
        statusLabel.textColor = .secondaryLabel
        statusLabel.font = .systemFont(ofSize: 16, weight:  .regular)
        statusLabel.translatesAutoresizingMaskIntoConstraints = false
        return statusLabel
    }()
    
    // MARK: - Init
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.backgroundColor = .secondarySystemBackground
        contentView.addSubviews(imageView, nameLabel, statusLabel)
        addConstraints()
        setupLayer()
    }
    
    required init?(coder: NSCoder) {
        fatalError("Unsupported")
    }
    
    private func setupLayer(){
        contentView.layer.cornerRadius = 8
        contentView.layer.shadowColor = UIColor.secondaryLabel.cgColor
        contentView.layer.cornerRadius = 4
        contentView.layer.shadowOffset = CGSize(width: -4, height: 4)
        contentView.layer.shadowOpacity = 0.3
    }
    
    private func addConstraints(){
        NSLayoutConstraint.activate([
                statusLabel.heightAnchor.constraint(equalToConstant: 30),
                nameLabel.heightAnchor.constraint(equalToConstant: 30),
                
                statusLabel.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 7),
                statusLabel.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -7),
                
                nameLabel.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 7),
                nameLabel.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -7),
                
                statusLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -3),
                nameLabel.bottomAnchor.constraint(equalTo: statusLabel.topAnchor),
                
                imageView.topAnchor.constraint(equalTo: contentView.topAnchor),
                imageView.leftAnchor.constraint(equalTo: contentView.leftAnchor),
                imageView.rightAnchor.constraint(equalTo: contentView.rightAnchor),
                imageView.bottomAnchor.constraint(equalTo: nameLabel.topAnchor, constant: -3),
            /*
                | Image |
                | name |
                | status |
                 */
        ])
//        imageView.backgroundColor = .systemGreen
//        nameLabel.backgroundColor = .red
//        statusLabel.backgroundColor = .orange
    }
    
    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        super.traitCollectionDidChange(previousTraitCollection)
        setupLayer()
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        imageView.image = nil
        nameLabel.text = nil
        statusLabel.text = nil
    }
    
    public func configure(with viewModel: RMCharacterCollectionViewCellVewModel){
        nameLabel.text = viewModel.characterName
        statusLabel.text = viewModel.characterStatusText
        viewModel.fetchImage{
            [weak self] result in
            switch result {
            case .success(let data):
                DispatchQueue.main.async{
                    let image = UIImage(data: data)
                    self?.imageView.image = image
                }
            case .failure(let error):
                print(String(describing: error))
                break
            }
        }
    }
}
