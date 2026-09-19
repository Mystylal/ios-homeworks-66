//
//  ProfileCoordinator.swift
//  Navigation
//
//  Created by Mysty Mystylal on 02.08.2026.
//

import UIKit
import FirebaseAuth

final class ProfileCoordinator: Coordinator {
    
    private (set) var childCoordinators: [Coordinator] = []
    private let navigationController = UINavigationController()
    private var loginInspector: LoginInspector?
    
    func start() -> UIViewController {
        if Auth.auth().currentUser != nil {
            let email = Auth.auth().currentUser?.email ?? ""
            let user = User(login: email, fullName: email, avatar: UIImage(named: "fish 1") ?? UIImage(), status: "Waiting for something...")
            let viewModel = ProfileViewModel()
            let profile = ProfileViewController(user: user, viewModel: viewModel)
            profile.coordinator = self
            navigationController.pushViewController(profile, animated: true)
            return navigationController
        } else {
            let loginFactory = MyLoginFactory()
            let inspector = loginFactory.makeLoginInspector()
            self.loginInspector = inspector
            let loginVC = LogInViewController(loginDelegate:inspector)
            loginVC.coordinator = self
            navigationController.setViewControllers([loginVC], animated: false)
            return navigationController
        }
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
