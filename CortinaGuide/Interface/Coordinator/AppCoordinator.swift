//
//  AppCoordinator.swift
//  CortinaGuide
//
//  Created by Nordy Vlasman on 20/12/2021.
//

import Foundation
import UIKit

protocol AppCoordinatorDelegate: AnyObject {
    
    func handleLaunchState(_ state: LaunchState)
    
    /// Retry loading the requirements
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
        
        guard childCoordinators.isEmpty else {
            if childCoordinators.first is BaseCoordinator {
                childCoordinators.first?.start()
            }
            return
        }
        
        let coordinator = BaseCoordinator(navigationController: navigationController, window: window)
        startChildCoordinator(coordinator)
    }
    
}

// MARK: - AppCoordinatorDelegate
extension AppCoordinator: AppCoordinatorDelegate {
    
    func handleLaunchState(_ state: LaunchState) {
        
        switch state {
        case .noActionNeeded:
            startApplication()
        case .internetRequired:
            print("internet is required")
        }
    }
    
    func retry() {
        
        if let presentedViewController = navigationController.presentedViewController {
            presentedViewController.dismiss(animated: true) { [weak self] in
                self?.startLauncher()
            }
        } else {
            startLauncher()
        }
    }
    
    func reset() {
    
        isApplicationStarted = false
        childCoordinators = []
        retry()
    }
}
