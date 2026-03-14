//
//  PostTableViewCell.swift
//  Navigation
//
//  Created by Mysty Mystylal on 14.03.2026.
//

import UIKit

class PostTableViewCell: UITableViewCell {

    private lazy var authorLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 20, weight: .bold)
        label.textColor = .black
        label.numberOfLines = 2
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var postImageView: UIImageView = {
        let postImage = UIImageView()
        postImage.contentMode = .scaleAspectFit
        postImage.backgroundColor = .black
        postImage.translatesAutoresizingMaskIntoConstraints = false
        return postImage
    }()
    
    private lazy var descriptionLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14)
        label.textColor = .systemGray
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var likesLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 16)
        label.textColor = .black
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var viewsLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 16)
        label.textColor = .black
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle,reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier:reuseIdentifier)
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func update(_ post: Post) {
        authorLabel.text = post.author
        postImageView.image = UIImage(named: post.image)
        descriptionLabel.text = post.description
        likesLabel.text = "Likes: \(post.likes)"
        viewsLabel.text = "Views: \(post.views)"
    }
    
    private func setupViews() {
        contentView.addSubview(authorLabel)
        contentView.addSubview(postImageView)
        contentView.addSubview(descriptionLabel)
        contentView.addSubview(likesLabel)
        contentView.addSubview(viewsLabel)
        
        NSLayoutConstraint.activate([
            authorLabel.topAnchor.constraint(equalTo:contentView.topAnchor, constant: 16),
            authorLabel.leadingAnchor.constraint(equalTo:contentView.leadingAnchor, constant: 16),
            authorLabel.trailingAnchor.constraint(equalTo:contentView.trailingAnchor, constant:-16),
                          
            postImageView.topAnchor.constraint(equalTo:authorLabel.bottomAnchor, constant: 16),
            postImageView.leadingAnchor.constraint(equalTo:contentView.leadingAnchor),
            postImageView.trailingAnchor.constraint(equalTo:contentView.trailingAnchor),
            postImageView.heightAnchor.constraint(equalTo:postImageView.widthAnchor),
                          
            descriptionLabel.topAnchor.constraint(equalTo:postImageView.bottomAnchor, constant: 16),
            descriptionLabel.leadingAnchor.constraint(equalTo:contentView.leadingAnchor, constant: 16),
            descriptionLabel.trailingAnchor.constraint(equalTo:contentView.trailingAnchor, constant: -16),
                          
            likesLabel.topAnchor.constraint(equalTo:descriptionLabel.bottomAnchor, constant: 16),
            likesLabel.leadingAnchor.constraint(equalTo:contentView.leadingAnchor, constant: 16),
            likesLabel.bottomAnchor.constraint(equalTo:contentView.bottomAnchor, constant: -16),
                          
            viewsLabel.topAnchor.constraint(equalTo:descriptionLabel.bottomAnchor, constant: 16),
            viewsLabel.trailingAnchor.constraint(equalTo:contentView.trailingAnchor, constant: -16),
            viewsLabel.bottomAnchor.constraint(equalTo:contentView.bottomAnchor, constant: -16)
              ])
    }
}
