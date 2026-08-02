//
//  ProfileCoordinator.swift
//  Navigation
//
//  Created by Mysty Mystylal on 02.08.2026.
//

import UIKit

final class ProfileCoordinator: Coordinator {
    
    private (set) var childCoordinators: [Coordinator] = []
    private let navigationController = UINavigationController()
    
    func start() -> UIViewController {
        let loginVC = LogInViewController()
        loginVC.coordinator = self
        let loginFactory = MyLoginFactory()
        loginVC.loginDelegate = loginFactory.makeLoginInspector()
        navigationController.setViewControllers([loginVC], animated: false)
        return navigationController
    }
    
    func showProfile(_ user: User) {
        let viewModel = ProfileViewModel()
        let profile = ProfileViewController(user: user, viewModel: viewModel)
        profile.coordinator = self
        navigationController.pushViewController(profile, animated: true)
    }
    
    func showPhotos() {
        let photosViewController = PhotosViewController()
        navigationController.pushViewController(photosViewController, animated: true)
    }
    
}
