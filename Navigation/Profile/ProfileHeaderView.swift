//
//  ProfileHeaderView.swift
//  Navigation
//
//  Created by Mysty Mystylal on 11.03.2026.
//

import UIKit
                                                                               
  class ProfileHeaderView: UIView {
      
      
      private lazy var avatarImageView: UIImageView = {
          let imageView = UIImageView()
          imageView.image = UIImage(named:"fish 1")
          imageView.clipsToBounds = true
          imageView.layer.cornerRadius = 50
          imageView.layer.borderWidth = 3
          imageView.layer.borderColor = UIColor.white.cgColor
          imageView.translatesAutoresizingMaskIntoConstraints = false
          return imageView
      }()
      
      private lazy var fullNameLabel: UILabel = {
          let label = UILabel()
          label.text = "Hipster Cat"
          label.font = UIFont.boldSystemFont(ofSize: 18)
          label.textColor = .black
          label.translatesAutoresizingMaskIntoConstraints = false
          return label
      }()
      
      private lazy var statusLabel: UILabel = {
          let label = UILabel()
          label.text = "Waiting for something..."
          label.font = UIFont.boldSystemFont(ofSize: 14)
          label.textColor = .gray
          label.translatesAutoresizingMaskIntoConstraints = false
          return label
      }()
      
      private lazy var setStatusButton: UIButton = {
          let button = UIButton()
          button.backgroundColor = .systemBlue
          button.setTitle("Show status", for: .normal)
          button.setTitleColor(.white, for: .normal)
          button.layer.cornerRadius = 4
          button.layer.shadowColor = UIColor.black.cgColor
          button.layer.shadowOpacity = 0.7
          button.layer.shadowOffset = CGSize(width: 4, height: 4)
          button.translatesAutoresizingMaskIntoConstraints = false
          return button
      }()
              
      private lazy var statusTextField: UITextField = {
          let textField = UITextField()
          textField.placeholder = "Введите статус..."
          textField.font = UIFont.systemFont(ofSize: 15)
          textField.layer.cornerRadius = 12
          textField.backgroundColor = .white
          textField.layer.borderWidth = 1
          textField.layer.borderColor = UIColor.black.cgColor
          textField.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height:0))
          textField.leftViewMode = .always
          textField.translatesAutoresizingMaskIntoConstraints = false
          return textField
        }()
      
     
      
      func setupViews() {
          addSubview(avatarImageView)
          addSubview(fullNameLabel)
          addSubview(statusLabel)
          addSubview(statusTextField)
          addSubview(setStatusButton)
          setStatusButton.addTarget(self, action: #selector(buttonPressed), for: .touchUpInside)
          setupConstraints()
        }
      
      private func setupConstraints() {
          NSLayoutConstraint.activate([
            avatarImageView.topAnchor.constraint(equalTo: topAnchor, constant: 16),
            avatarImageView.leadingAnchor.constraint(equalTo: leadingAnchor,constant: 16),
            avatarImageView.widthAnchor.constraint(equalToConstant: 100),
            avatarImageView.heightAnchor.constraint(equalToConstant: 100),
                                                                                     
            fullNameLabel.topAnchor.constraint(equalTo: topAnchor, constant: 27),
            fullNameLabel.leadingAnchor.constraint(equalTo: avatarImageView.trailingAnchor, constant: 16),
            fullNameLabel.trailingAnchor.constraint(equalTo: trailingAnchor,constant: -16),
                        
            statusLabel.topAnchor.constraint(equalTo: fullNameLabel.bottomAnchor,constant: 16),
            statusLabel.leadingAnchor.constraint(equalTo:avatarImageView.trailingAnchor, constant: 16),
            statusLabel.trailingAnchor.constraint(equalTo: trailingAnchor,constant: -16),
                        
            statusTextField.topAnchor.constraint(equalTo:statusLabel.bottomAnchor, constant: 10),
            statusTextField.leadingAnchor.constraint(equalTo:avatarImageView.trailingAnchor, constant: 16),
            statusTextField.trailingAnchor.constraint(equalTo: trailingAnchor,constant: -16),
            statusTextField.heightAnchor.constraint(equalToConstant: 40),
                                                                                         
            setStatusButton.topAnchor.constraint(equalTo: avatarImageView.bottomAnchor,constant: 34),
            setStatusButton.leadingAnchor.constraint(equalTo: leadingAnchor, constant:16),
            setStatusButton.trailingAnchor.constraint(equalTo: trailingAnchor,constant: -16),
            setStatusButton.heightAnchor.constraint(equalToConstant: 50)
          ])
       }
             
      
      @objc func buttonPressed() {
           print(statusLabel.text ?? "")
       }
  }
