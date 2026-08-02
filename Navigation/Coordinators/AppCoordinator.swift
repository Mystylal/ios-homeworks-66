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
    
    func start() -> UIViewController {
        let feedCoordinator = FeedCoordinator()
        let feedVC = feedCoordinator.start()
        feedVC.tabBarItem = UITabBarItem(title: "Feed", image:UIImage(systemName: "house"), tag:0)
        addChildCoordinator(feedCoordinator)
        
        let profileCoordinator = ProfileCoordinator()
        let profileVC = profileCoordinator.start()
        profileVC.tabBarItem = UITabBarItem(title: "Profile", image:UIImage(systemName: "person"), tag:0)
        addChildCoordinator(profileCoordinator)
        
        tabBarController.viewControllers = [feedVC, profileVC]
        return tabBarController
    }
    
    func addChildCoordinator(_ coordinator: Coordinator) {
        guard !childCoordinators.contains(where: { $0 === coordinator }) else { return }
        childCoordinators.append(coordinator)
    }
    
    func removeChildCoordinator(_ coordinator: Coordinator) {
        childCoordinators = childCoordinators.filter { $0 !== coordinator }
    }
}
