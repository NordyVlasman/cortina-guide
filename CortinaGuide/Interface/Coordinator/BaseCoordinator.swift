//
//  BaseCoordinator.swift
//  CortinaGuide
//
//  Created by Nordy Vlasman on 20/12/2021.
//

import Foundation

protocol BaseCoordinatorDelegate: AnyObject {
    
    func navigateToHome()
    
    func navigateToAugmentedReality()
    
}

class BaseCoordinator: SharedCoordinator {
    
    var onboardingFactory: OnboardingFactoryProtocol = OnboardingFactory()
    
    override func start() {
        handleOnboarding(factory: onboardingFactory) {
            setupView()
            navigateToHome()
        }
    }
    
    fileprivate func setupView() {
        dashboardNavigationController = NavigationController()
        self.window.rootViewController = self.dashboardNavigationController
    }
}


// MARKL - BaseCoordinatorDelegate
extension BaseCoordinator: BaseCoordinatorDelegate {
    func navigateToHome() {
        if window.rootViewController != self.dashboardNavigationController {
            self.window.rootViewController = self.dashboardNavigationController
        }
        if let existingStartViewController = dashboardNavigationController?.viewControllers.first(where: { $0 is HomeViewController }) {
            dashboardNavigationController?.popToViewController(existingStartViewController, animated: true)
        } else {
            let dashboardViewController = HomeViewController(viewModel: HomeViewModel(coordinator: self))
            
            dashboardNavigationController?.setViewControllers([dashboardViewController], animated: false)
        }
    }
    
    func navigateToAugmentedReality() {
        if self.window.rootViewController is ARViewController {
            return
        } else {
            let viewController = ARViewController(viewModel: ARViewModel(coordinator: self))
            self.window.rootViewController = viewController
        }
    }
}
