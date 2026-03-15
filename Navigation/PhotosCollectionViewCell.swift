//
//  PhotosCollectionViewCell.swift
//  Navigation
//
//  Created by Mysty Mystylal on 15.03.2026.
//

import UIKit

class PhotosCollectionViewCell: UICollectionViewCell {
    private lazy var photoImageView: UIImageView = {
             let imageView = UIImageView()
             imageView.contentMode = .scaleAspectFill
             imageView.clipsToBounds = true
             imageView.translatesAutoresizingMaskIntoConstraints = false
             return imageView
         }()

         override init(frame: CGRect) {
             super.init(frame: frame)
             setupViews()
         }

         required init?(coder: NSCoder) {
             fatalError("init(coder:) has not been implemented")
         }

         func update(_ photo: String) {
             photoImageView.image = UIImage(named: photo)
         }

         private func setupViews() {
             contentView.addSubview(photoImageView)
             NSLayoutConstraint.activate([
                 photoImageView.topAnchor.constraint(equalTo: contentView.topAnchor),
                 photoImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
                 photoImageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
                 photoImageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
             ])
         }

}
