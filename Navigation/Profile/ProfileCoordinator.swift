//
//  ProfileCoordinator.swift
//  Navigation
//
//  Created by Mysty Mystylal on 24.07.2026.
//

import UIKit

class ProfileCoordinator: Coordinator {
    var childCoordinators: [Coordinator] = []
    var navigationController: UINavigationController?
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        let loginViewController = LogInViewController()
        loginViewController.coordinator = self
        let loginFactory = MyLoginFactory()
        loginViewController.loginDelegate = loginFactory.makeLoginInspector()
        navigationController?.setViewControllers([loginViewController], animated: false)
    }
    
    func showProfile(user: User) {
        let viewModel = ProfileViewModel()
        let profile = ProfileViewController(user: user, viewModel: viewModel)
        navigationController?.pushViewController(profile, animated: true)
    }
}
