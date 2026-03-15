//
//  PhotosTableViewCell.swift
//  Navigation
//
//  Created by Mysty Mystylal on 14.03.2026.
//

import UIKit

class PhotosTableViewCell: UITableViewCell {

    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.text = "Photos"
        label.font = UIFont.systemFont(ofSize: 24, weight: .bold)
        label.textColor = .black
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var arrowButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(UIImage(systemName: "arrow.right"), for:.normal)
        button.tintColor = .black
        button.isUserInteractionEnabled = false
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private lazy var photosStackView: UIStackView = {
        let photosStack = UIStackView()
        photosStack.axis = .horizontal
        photosStack.spacing = 8
        photosStack.distribution = .fillEqually
        photosStack.translatesAutoresizingMaskIntoConstraints = false
        for _ in 1...4 {
            let imageView = UIImageView()
            imageView.contentMode = .scaleAspectFill
            imageView.layer.cornerRadius = 6
            imageView.clipsToBounds = true
            photosStack.addArrangedSubview(imageView)
        }
        return photosStack
    }()
    
    func update(_ photos: [String]) {
        let imageViews = photosStackView.arrangedSubviews.compactMap{ $0 as? UIImageView }
        for (index, imageView) in imageViews.enumerated() {
            imageView.image = UIImage(named: photos[index])
        }
    }
    
    override init(style: UITableViewCell.CellStyle,reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier:reuseIdentifier)
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupViews(){
        contentView.addSubview(titleLabel)
        contentView.addSubview(arrowButton)
        contentView.addSubview(photosStackView)
        
        let imageSize = (UIScreen.main.bounds.width - 12 * 2 - 8 * 3 ) / 4
        
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo:contentView.topAnchor, constant: 12),
            titleLabel.leadingAnchor.constraint(equalTo:contentView.leadingAnchor, constant: 12),

            arrowButton.centerYAnchor.constraint(equalTo:titleLabel.centerYAnchor),
            arrowButton.trailingAnchor.constraint(equalTo:contentView.trailingAnchor, constant: -12),

            photosStackView.topAnchor.constraint(equalTo:titleLabel.bottomAnchor, constant: 12),
            photosStackView.leadingAnchor.constraint(equalTo:contentView.leadingAnchor, constant: 12),
            photosStackView.trailingAnchor.constraint(equalTo:contentView.trailingAnchor, constant: -12),
            photosStackView.heightAnchor.constraint(equalToConstant:imageSize),
            photosStackView.bottomAnchor.constraint(equalTo:contentView.bottomAnchor, constant: -12)
        ])

        
    }
    
    
}
