//
//  ProfileHeaderView.swift
//  Navigation
//
//  Created by Mysty Mystylal on 11.03.2026.
//

import UIKit
                                                                               
  class ProfileHeaderView: UIView {
      
      
      let avatarImage: UIImageView = {
          let imageView = UIImageView()
          imageView.image = UIImage(named:"fish 1")
          imageView.clipsToBounds = true
          imageView.layer.cornerRadius = 50
          imageView.layer.borderWidth = 3
          imageView.layer.borderColor = UIColor.white.cgColor
          return imageView
      }()
      
      let nameLabel: UILabel = {
          let label = UILabel()
          label.text = "Hipster Cat"
          label.font = UIFont.boldSystemFont(ofSize: 18)
          label.textColor = .black
          return label
      }()
      
      let statusLabel: UILabel = {
          let label = UILabel()
          label.text = "Waiting for something..."
          label.font = UIFont.boldSystemFont(ofSize: 14)
          label.textColor = .gray
          return label
      }()
      
      let showButton: UIButton = {
          let button = UIButton()
          button.backgroundColor = .systemBlue
          button.setTitle("Show status", for: .normal)
          button.setTitleColor(.white, for: .normal)
          button.layer.cornerRadius = 4
          button.layer.shadowColor = UIColor.black.cgColor
          button.layer.shadowOpacity = 0.7
          button.layer.shadowOffset = CGSize(width: 4, height: 4)
          return button
      }()
                                                                                     

      override func layoutSubviews() {
          super.layoutSubviews()
          
          addSubview(avatarImage)
          addSubview(nameLabel)
          addSubview(statusLabel)
          addSubview(showButton)
          avatarImage.frame = CGRect(x: 16, y: safeAreaInsets.top + 16, width: 100, height: 100)
          nameLabel.frame = CGRect(x: 132, y: safeAreaInsets.top + 27, width: frame.width - 132 - 16, height: 24)
          statusLabel.frame = CGRect(x: 132, y: safeAreaInsets.top + 80, width: frame.width - 132 - 16, height: 22)
          showButton.frame = CGRect(x: 16, y: safeAreaInsets.top + 130, width: frame.width - 16 - 16,
           height: 50)
          
          showButton.addTarget(self, action: #selector(buttonPressed), for:
            .touchUpInside)
          
      }
      
      @objc func buttonPressed() {
           print(statusLabel.text ?? "")
       }
  }
