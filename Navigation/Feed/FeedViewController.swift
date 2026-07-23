//
//  FeedViewController.swift
//  Navigation
//
//  Created by Mysty Mystylal on 10.03.2026.
//

import UIKit
import StorageService

class FeedViewController: UIViewController {
    private let post = Post(author: "Hipster Cat", description: "Тестовый пост", image: "fish 1", likes: 100, views: 500)
    
    private lazy var guessTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Введите текст"
        textField.borderStyle = .roundedRect
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    
    private lazy var checkGuessButton: CustomButton = {
        CustomButton(title: "Проверить ответ", titleColor: .white) { [weak self] in
            self?.checkGuess()
        }
    }()
    
    private lazy var resultLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Feed"
        view.backgroundColor = .systemGray
        
        let button = CustomButton(title: "Открыть пост", titleColor: .white) { [weak self] in
            self?.buttonPressed()
        }
        view.addSubview(button)
        view.addSubview(guessTextField)
        view.addSubview(checkGuessButton)
        view.addSubview(resultLabel)
        
        NSLayoutConstraint.activate([
                      button.centerXAnchor.constraint(equalTo: view.centerXAnchor),
                      button.centerYAnchor.constraint(equalTo: view.centerYAnchor),
                      
                      guessTextField.topAnchor.constraint(equalTo: button.bottomAnchor, constant: 20),
                      guessTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
                      guessTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
                      
                      checkGuessButton.topAnchor.constraint(equalTo: guessTextField.bottomAnchor, constant: 10),
                      checkGuessButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
                      checkGuessButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
                      
                      resultLabel.topAnchor.constraint(equalTo: checkGuessButton.bottomAnchor, constant: 10),
                      resultLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor)
                  ])

    }

    func buttonPressed() {
        let postController = PostViewController()
        postController.post = post
        navigationController?.pushViewController(postController, animated: true)
    }
    
    private let feedModel = FeedModel()
    
    private func checkGuess() {
        guard let word = guessTextField.text?.lowercased(), !word.isEmpty else { return }
        
        feedModel.check(word: word) { [weak self] isRight in
            self?.resultLabel.text = isRight ? "Верно" : "Не верно"
            self?.resultLabel.textColor = isRight ? .systemGreen : .systemRed
        }
    }
}
