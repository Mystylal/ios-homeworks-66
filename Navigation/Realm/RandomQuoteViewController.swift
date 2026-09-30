//
//  RandomQuoteViewController.swift
//  Navigation
//
//  Created by Mysty Mystylal on 29.09.2026.
//

import UIKit
import Foundation

class RandomQuoteViewController: UIViewController {
    private let service = ChuckNorrisService()
    private let repository = QuoteRepository()
    
    private lazy var label: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.numberOfLines = 0
        label.textColor = .black
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var actionButton : CustomButton = {
        CustomButton(title: " ", titleColor: .white, backgroundColor: .systemBlue) {
            [weak self] in self?.actionButtonTup()}
    }()
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        title = "Цитата"
        actionButton.setTitle("Загрузить", for: .normal)
        view.addSubview(label)
        view.addSubview(actionButton)
        
        let safeAreaGuide = view.safeAreaLayoutGuide
        NSLayoutConstraint.activate([
            label.topAnchor.constraint(equalTo: safeAreaGuide.topAnchor, constant: 100),
            label.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            label.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            
            actionButton.topAnchor.constraint(equalTo: label.bottomAnchor, constant: 24),
            actionButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            actionButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            actionButton.heightAnchor.constraint(equalToConstant: 50)
        ])
        
    }
    
    private func actionButtonTup() {
        service.getRandomQuote { [weak self] result in
            DispatchQueue.main.async {
                switch result {
                    case .success(let quote):
                    self?.label.text = quote.value
                    self?.repository.save(quote)
                case .failure(let error):
                    self?.label.text = "Ошибка: \(error)"
                }
            }
        }
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
