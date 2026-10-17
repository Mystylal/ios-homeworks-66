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
        let DocumentCoordinator = DocumentCoordinator()
        let DocumentVC = DocumentCoordinator.start()
        DocumentVC.tabBarItem = UITabBarItem(title: "Document", image:UIImage(systemName: "folder"), tag:0)
        addChildCoordinator(DocumentCoordinator)
        
        let SettingsCoordinator = SettingsViewController()
        let SettingsVC = UINavigationController(rootViewController: SettingsCoordinator)
        SettingsVC.tabBarItem = UITabBarItem(title: "Settings", image:UIImage(systemName: "gearshape"), tag:1)
        
        tabBarController.viewControllers = [DocumentVC, SettingsVC]
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
