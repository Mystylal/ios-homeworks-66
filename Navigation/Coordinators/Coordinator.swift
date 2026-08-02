//
//  Coordinator.swift
//  Navigation
//
//  Created by Mysty Mystylal on 02.08.2026.
//

import UIKit

protocol Coordinator: AnyObject {
    var childCoordinators: [Coordinator] { get }
    func start() -> UIViewController
    func addChildCoordinator(_ coordinator: Coordinator)
    func removeChildCoordinator(_ coordinator: Coordinator)
}

extension Coordinator {
    func addChildCoordinator(_ coordinator: Coordinator) {}
    func removeChildCoordinator(_ coordinator: Coordinator) {}
}
