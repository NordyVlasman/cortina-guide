//
//  ARViewModel.swift
//  CortinaGuide
//
//  Created by Nordy Vlasman on 21/12/2021.
//

import Foundation

class ARViewModel {
    
    /// Coordinator delegate
    weak var coordinator: BaseCoordinatorDelegate?
    
    /// Initializer
    /// - Parameters:
    ///   - coordinator: the coordinator delegate
    init(coordinator: BaseCoordinatorDelegate) {
        self.coordinator = coordinator
    }
    
    func dimiss() {
        coordinator?.navigateToHome()
    }
}
