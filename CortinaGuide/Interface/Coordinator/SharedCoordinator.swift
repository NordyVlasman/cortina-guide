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
