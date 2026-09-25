//
//  DocumentsCoordinator.swift
//  Navigation
//
//  Created by Mysty Mystylal on 25.09.2026.
//

import UIKit

final class DocumentCoordinator: Coordinator {
    
    private (set) var childCoordinators: [Coordinator] = []
    private let navigationController = UINavigationController()
    
    func start() -> UIViewController {
        let documentVC = DocumentsViewController()
        navigationController.setViewControllers([documentVC], animated: false)
        return navigationController
    }
    
}
