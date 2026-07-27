//
//  Coordinator.swift
//  Navigation
//
//  Created by Mysty Mystylal on 24.07.2026.
//

import UIKit

protocol Coordinator: AnyObject {
    var childCoordinators: [Coordinator] { get set }
    var navigationController: UINavigationController? { get set }
    func start()
}

class AppCoordinator: Coordinator {
    var childCoordinators: [Coordinator] = []
    var navigationController: UINavigationController?
    
    let tabBarController = UITabBarController()
    
    func start() {
        let feedNavController = UINavigationController()
        let feedCoordinator = FeedCoordinator(navigationController: feedNavController)
        feedCoordinator.start()
        childCoordinators.append(feedCoordinator)
        feedNavController.tabBarItem = UITabBarItem(title: "Feed", image:UIImage(systemName: "house"), tag:0)
        
        let profileNavController = UINavigationController()
        let profileCoordinator = ProfileCoordinator(navigationController: profileNavController)
        profileCoordinator.start()
        childCoordinators.append(profileCoordinator)
        profileNavController.tabBarItem = UITabBarItem(title: "Profile", image:UIImage(systemName: "person"), tag:0)
        
        tabBarController.viewControllers = [feedNavController, profileNavController]
        
    }
}
