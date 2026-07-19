//
//  ProfileHeaderView.swift
//  Navigation
//
//  Created by Mysty Mystylal on 11.03.2026.
//

import UIKit
import SnapKit
                                                                               
  class ProfileHeaderView: UIView {
      
      
      private lazy var avatarImageView: UIImageView = {
          let imageView = UIImageView()
          imageView.image = UIImage(named:"fish 1")
          imageView.clipsToBounds = true
          imageView.layer.cornerRadius = 50
          imageView.layer.borderWidth = 3
          imageView.layer.borderColor = UIColor.white.cgColor
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
      
     
      var onAvatarTap: (() -> Void)?
      
      func setupViews() {
          addSubview(avatarImageView)
          addSubview(fullNameLabel)
          addSubview(statusLabel)
          addSubview(statusTextField)
          addSubview(setStatusButton)
          setStatusButton.addTarget(self, action: #selector(buttonPressed), for: .touchUpInside)
          setupConstraints()
          avatarImageView.isUserInteractionEnabled = true
          let tapGesture = UITapGestureRecognizer(target: self, action: #selector(avatarTapped))
          avatarImageView.addGestureRecognizer(tapGesture)

        }
      
      private func setupConstraints() {
          
          avatarImageView.snp.makeConstraints{ make in
              make.top.leading.equalToSuperview().offset(16)
              make.width.height.equalTo(100)
          }
          
          fullNameLabel.snp.makeConstraints{ make in
              make.top.equalToSuperview().offset(27)
              make.leading.equalTo(avatarImageView.snp.trailing).offset(16)
              make.trailing.equalToSuperview().offset(-16)
          }
          
          statusLabel.snp.makeConstraints{ make in
              make.top.equalTo(fullNameLabel.snp.bottom).offset(16)
              make.leading.equalTo(avatarImageView.snp.trailing).offset(16)
              make.trailing.equalToSuperview().offset(-16)
          }
          
          statusTextField.snp.makeConstraints{ make in
              make.top.equalTo(statusLabel.snp.bottom).offset(10)
              make.leading.equalTo(avatarImageView.snp.trailing).offset(16)
              make.trailing.equalToSuperview().offset(-16)
              make.height.equalTo(40)
          }
          
          setStatusButton.snp.makeConstraints{ make in
              make.top.equalTo(avatarImageView.snp.bottom).offset(34)
              make.leading.equalToSuperview().offset(16)
              make.trailing.equalToSuperview().offset(-16)
              make.height.equalTo(50)
          }
                                                                                    
        
       }
             
      
      @objc func buttonPressed() {
           print(statusLabel.text ?? "")
       }
      
      @objc private func avatarTapped() {
           onAvatarTap?()
       }
  }
