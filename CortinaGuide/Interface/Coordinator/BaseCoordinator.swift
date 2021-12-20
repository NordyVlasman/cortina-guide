//
//  BaseCoordinator.swift
//  CortinaGuide
//
//  Created by Nordy Vlasman on 20/12/2021.
//

import Foundation

protocol BaseCoordinatorDelegate {
    
    func navigateToHome()
    
}

class BaseCoordinator: SharedCoordinator {
    
    override func start() {
        setupView()
        navigateToHome()
    }
    
    fileprivate func setupView() {
        dashboardNavigationController = NavigationController()
        window.rootViewController = dashboardNavigationController
    }
}


// MARKL - BaseCoordinatorDelegate
extension BaseCoordinator: BaseCoordinatorDelegate {
    func navigateToHome() {
        if let existingStartViewController = dashboardNavigationController?.viewControllers.first(where: { $0 is HomeViewController }) {
            dashboardNavigationController?.popToViewController(existingStartViewController, animated: true)
        } else {
            let dashboardViewController = HomeViewController()
            
            dashboardNavigationController?.setViewControllers([dashboardViewController], animated: false)
        }
    }
}
