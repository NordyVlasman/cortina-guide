//
//  Coordinator.swift
//  CortinaGuide
//
//  Created by Nordy Vlasman on 20/12/2021.
//

import UIKit

protocol Coordinator: AnyObject {
    
    /// The child coordinators
    var childCoordinators: [Coordinator] { get set }
    
    /// The navigation controller
    var navigationController: UINavigationController { get set }
    
    // Designated starter method
    func start()
}

extension Coordinator {
    
    /// Add a child coordinator
    /// - Parameter coordinator: the coordinator to add
    func addChildCoordinator(_ coordinator: Coordinator) {
        if !childCoordinators.contains(where: { $0 === coordinator }) {
            childCoordinators.append(coordinator)
        }
    }
    
    /// Remove a child coordinator
    /// - Parameter coordinator: the coordinator to remove
    func removeChildCoordinator(_ coordinator: Coordinator) {
        if let index = childCoordinators.firstIndex(where: { $0 === coordinator }) {
            childCoordinators.remove(at: index)
        }
    }
    
    /// Add a child coordinator and start it
    /// - Parameter coordinator: the coordinator to add and start
    func startChildCoordinator(_ coordinator: Coordinator) {
        addChildCoordinator(coordinator)
        coordinator.start()
    }
}
