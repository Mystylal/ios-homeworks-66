//
//  FeedViewController.swift
//  Navigation
//
//  Created by Mysty Mystylal on 10.03.2026.
//

import UIKit

class FeedViewController: UIViewController {
    private let post = Post(title:"Постик")
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Feed"
        view.backgroundColor = .systemGray
        
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Открыть пост", for: .normal)
        button.addTarget(self, action: #selector(buttonPressed(_:)), for:.touchUpInside)
        view.addSubview(button)
        
        NSLayoutConstraint.activate([
                      button.centerXAnchor.constraint(equalTo: view.centerXAnchor),
                      button.centerYAnchor.constraint(equalTo: view.centerYAnchor)
                  ])

    }

    @objc func buttonPressed(_ sender: UIButton) {
        let postController = PostViewController()
        postController.post = post
        navigationController?.pushViewController(postController, animated: true)
    }
}

