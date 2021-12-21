//
//  SharedCoordinator.swift
//  CortinaGuide
//
//  Created by Nordy Vlasman on 20/12/2021.
//

import UIKit

protocol Restartable: AnyObject {
    func restart()
}

class SharedCoordinator: Coordinator {
    
    var window: UIWindow
    
    var onboardingManager: OnboardingManaging = Services.onboardingManager
    var childCoordinators: [Coordinator] = []
    
    var navigationController: UINavigationController
    var dashboardNavigationController: UINavigationController?
    
    init(navigationController: UINavigationController, window: UIWindow) {
        self.navigationController = navigationController
        self.window = window
    }
    
    func start() {
        // override this
    }
    
    
}

// MARK: - Shared

extension SharedCoordinator {
    func handleOnboarding(factory: OnboardingFactoryProtocol, onCompletion: () -> Void) {
        if onboardingManager.needsOnboarding {
            let coordinator = OnboardingCoordinator(navigationController: navigationController, onboardingDelegate: self, factory: factory)
            startChildCoordinator(coordinator)
            return
        } else if onboardingManager.needsConsent {
            let coordinator = OnboardingCoordinator(navigationController: navigationController, onboardingDelegate: self, factory: factory)
            startChildCoordinator(coordinator)
            coordinator.navigateToConsent()
            return
        }
        onCompletion()
    }
}

// MARK: - OnboardingDelegate

extension SharedCoordinator: OnboardingDelegate {
    func finishOnboarding() {
        onboardingManager.finishOnboarding()
    }
    
    func consentGiven() {
        onboardingManager.consentGiven()
        
        if let onboardingCoordinator = childCoordinators.first {
            removeChildCoordinator(onboardingCoordinator)
        }
        
        start()
    }
}

// MARK: - Restartable

extension SharedCoordinator: Restartable {
        
    /// Restart the app
    func restart() {
        if #available(iOS 13.0, *) {
            if let scene = UIApplication.shared.connectedScenes.first, let sceneDelegate: SceneDelegate = (scene.delegate as? SceneDelegate) {
                sceneDelegate.appCoordinator?.reset()
            }
        } else {
            if let appDelegate = UIApplication.shared.delegate as? AppDelegate {
                appDelegate.appCoordinator?.reset()
            }
        }
    }
}
