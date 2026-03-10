//
//  PostViewController.swift
//  Navigation
//
//  Created by Mysty Mystylal on 10.03.2026.
//

import UIKit

class PostViewController: UIViewController {
    var post:Post?
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Post"
        view.backgroundColor = .systemYellow
        title = post?.title
        
        let infoButton = UIBarButtonItem(
            title: "Info",
            style: .plain,
            target: self,
            action: #selector(infoButtonPressed))
        navigationItem.rightBarButtonItem = infoButton
    }
    @objc func infoButtonPressed(){
        let infoController = InfoViewController()
        present(infoController, animated: true)
    }
}
