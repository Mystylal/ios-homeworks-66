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
        let randomQuoteVC = UINavigationController(rootViewController: RandomQuoteViewController())
        randomQuoteVC.tabBarItem = UITabBarItem(title: "Случайная", image: UIImage(systemName: "quote.bubble"), tag: 0)
        let allQuotesVC = UINavigationController(rootViewController: AllQuotesViewController())
        allQuotesVC.tabBarItem = UITabBarItem(title: "Все цитаты", image: UIImage(systemName: "list.bullet"), tag: 1)
        let categoriesVC = UINavigationController(rootViewController: CategoriesViewController())
        categoriesVC.tabBarItem = UITabBarItem(title: "Категории", image: UIImage(systemName: "folder"), tag: 2)
        tabBarController.viewControllers = [randomQuoteVC, allQuotesVC, categoriesVC]
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
