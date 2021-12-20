//
//  LaunchViewModel.swift
//  CortinaGuide
//
//  Created by Nordy Vlasman on 20/12/2021.
//

import Foundation

class LaunchViewModel {
        
    private weak var coordinator: AppCoordinatorDelegate?
    
    init(
        coordinator: AppCoordinatorDelegate
    ) {
        self.coordinator = coordinator
        
        handleState()
    }
    
    private func handleState() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            self.coordinator?.handleLaunchState(.noActionNeeded)
        }
    }
}
