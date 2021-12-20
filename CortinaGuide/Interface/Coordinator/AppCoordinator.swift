//
//  AppCoordinator.swift
//  CortinaGuide
//
//  Created by Nordy Vlasman on 20/12/2021.
//

import Foundation
import UIKit

protocol AppCoordinatorDelegate: AnyObject {
    func retry()
    func reset()
}

class AppCoordinator: Coordinator {
    
    let window: UIWindow
    
    var childCoordinators: [Coordinator] = []
    
    var navigationController: UINavigationController

    // Flag to prevent starting the application more than once
    // which can happen with the config being fetched within the TTL.
    private var isApplicationStarted = false
    
    /// For use with iOS 13 and higher
    @available(iOS 13.0, *)
    init(scene: UIWindowScene, navigationController: UINavigationController) {

        window = UIWindow(windowScene: scene)
        self.navigationController = navigationController
    }

    /// For use with iOS 12.
    init(navigationController: UINavigationController) {

        self.window = UIWindow(frame: UIScreen.main.bounds)
        self.navigationController = navigationController
    }
    
    func start() {
        startLauncher()
    }
   
    // MARK: - Private functions
    
    /// Launch the launcher
    private func startLauncher() {
        let destination = LaunchViewController(
            viewModel: LaunchViewModel(coordinator: self)
        )
        
        window.rootViewController = navigationController
        window.makeKeyAndVisible()
        navigationController.viewControllers = [destination]
    }
    
    /// Start the real application
    private func startApplication() {
        guard !isApplicationStarted else { return }
        isApplicationStarted = true
    }
    
}

// MARK: - AppCoordinatorDelegate
extension AppCoordinator: AppCoordinatorDelegate {
    func retry() {
        
    }
    
    func reset() {
        isApplicationStarted = false
        childCoordinators = []
        retry()
    }
}
