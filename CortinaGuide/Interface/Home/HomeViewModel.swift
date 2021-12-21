//
//  HomeViewModel.swift
//  CortinaGuide
//
//  Created by Nordy Vlasman on 20/12/2021.
//

import Foundation

protocol HomeActionHandling {
    func didTapShowAR()
}

class HomeViewModel: HomeActionHandling {
    
    weak private var coordinator: BaseCoordinatorDelegate?
    
    init(coordinator: BaseCoordinatorDelegate) {
        self.coordinator = coordinator
    }
    
    func didTapShowAR() {
        coordinator?.navigateToAugmentedReality()
    }
}
