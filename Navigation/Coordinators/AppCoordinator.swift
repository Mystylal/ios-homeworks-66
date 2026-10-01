//
//  AppCoordinator.swift
//  Navigation
//
//  Created by Mysty Mystylal on 02.08.2026.
//

import UIKit

final class AppCoordinator: Coordinator {
    
    private (set) var childCoordinators: [Coordinator] = []
    let tabBarController = UITabBarController()
    private let navigationController = UINavigationController()
    private let passwordService = PasswordService()
    weak var window: UIWindow?
    
    func start() -> UIViewController {
        showPasswordScreen()
        navigationController.setNavigationBarHidden(true, animated: false)
        return navigationController
    }
    
    private func showPasswordScreen() {
        let mode: PasswordScreenMode = passwordService.hasPassword ? .verify : .create
        let passwordVC = PasswordViewController(mode: mode)
        passwordVC.onSuccess = { [weak self] in
            self?.showTabBar()
        }
        navigationController.setViewControllers([passwordVC], animated: false)
    }
    
    private func showTabBar() {
        let feedCoordinator = FeedCoordinator()
        let feedVC = feedCoordinator.start()
        feedVC.tabBarItem = UITabBarItem(title: "Feed", image:UIImage(systemName: "house"), tag:0)
        addChildCoordinator(feedCoordinator)
        
        let profileCoordinator = ProfileCoordinator()
        let profileVC = profileCoordinator.start()
        profileVC.tabBarItem = UITabBarItem(title: "Profile", image:UIImage(systemName: "person"), tag:0)
        addChildCoordinator(profileCoordinator)
        
        let DocumentCoordinator = DocumentCoordinator()
        let DocumentVC = DocumentCoordinator.start()
        DocumentVC.tabBarItem = UITabBarItem(title: "Document", image:UIImage(systemName: "folder"), tag:0)
        addChildCoordinator(DocumentCoordinator)
        
        let likedPostsVC = UINavigationController(rootViewController: LikedPostsViewController())
        likedPostsVC.tabBarItem = UITabBarItem(title: "Liked", image:UIImage(systemName: "heart"), tag:0)
        
        tabBarController.viewControllers = [feedVC, profileVC, DocumentVC, likedPostsVC]
        window?.rootViewController = tabBarController
       
    }
    
    func addChildCoordinator(_ coordinator: Coordinator) {
        guard !childCoordinators.contains(where: { $0 === coordinator }) else { return }
        childCoordinators.append(coordinator)
    }
        
    func removeChildCoordinator(_ coordinator: Coordinator) {
        childCoordinators = childCoordinators.filter { $0 !== coordinator }
    }
}
