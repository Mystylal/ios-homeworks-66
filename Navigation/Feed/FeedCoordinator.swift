//
//  FeedCoordinator.swift
//  Navigation
//
//  Created by Mysty Mystylal on 24.07.2026.
//

import UIKit
import StorageService

class FeedCoordinator: Coordinator {
    var childCoordinators: [Coordinator] = []
    var navigationController: UINavigationController?
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        let feedViewController = FeedViewController()
        feedViewController.coordinator = self
        navigationController?.setViewControllers([feedViewController], animated: false)
    }
    
    func showPost(post: Post) {
        let postController = PostViewController()
        postController.post = post
        navigationController?.pushViewController(postController, animated: true)
    }
}
