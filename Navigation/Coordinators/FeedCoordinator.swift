//
//  FeedCoordinator.swift
//  Navigation
//
//  Created by Mysty Mystylal on 02.08.2026.
//

import UIKit
import StorageService

final class FeedCoordinator: Coordinator {
    
    private (set) var childCoordinators: [Coordinator] = []
    private let navigationController = UINavigationController()
    
    func start() -> UIViewController {
        let feedVC = FeedViewController()
        feedVC.coordinator = self
        navigationController.setViewControllers([feedVC], animated: false)
        return navigationController
    }
    
    func showPost(_ post: Post) {
        let postController = PostViewController()
        postController.post = post
        navigationController.pushViewController(postController, animated: true)
    }
    
}
