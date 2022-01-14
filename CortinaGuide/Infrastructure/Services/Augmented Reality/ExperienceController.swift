//
//  ExperienceController.swift
//  CortinaGuide
//
//  Created by Nordy Vlasman on 14/01/2022.
//

import Foundation
import RealityKit

protocol ExperienceControllerObserver: AnyObject {
    /// Called when the experience controller's anchor content finishes loading
    func experienceControllerContentDidLoad(_ experienceController: Cortina.ExperienceController)
    
    func experienceControllerReadyForPlayer(_ experienceController: Cortina.ExperienceController)
    
    func experienceControllerReadyForContentPlacement(_ experienceController: Cortina.ExperienceController)
    
    func experienceController(_ experienceController: Cortina.ExperienceController, readyForPlayerToThrowBall experienceNumber: Int)
    
    func experienceController(_ experienceController: Cortina.ExperienceController, completedThrowingFrameWithStruckBike struckBike: Entity)
}

extension Cortina {
    
    public struct AnchorPlacement {
        var arAnchorIdentifier: UUID?
        
        var placementTransform: Transform?
    }
    
    class ExperienceController {
        indirect enum State: Equatable {
            case begin
            case appStart
            case menu
            case placingContent
            case waitingForContent(nextState: State)
            case readyToThrow
            case ballInMotion
            case ballAtRest
            case frameComplete(struckBike: Entity)
        }
        
        let settings = ExperienceSettings()
        
        var experienceAnchor: Cortina.Scene!
        
        var bikesInPlay = [Entity]()
        
        var currentPosition = 0
        
        var presentedInstructions = false
        
        var anchorPlacement: Cortina.AnchorPlacement?
        
        var ball: (Entity & HasPhysics)? {
            experienceAnchor?.bigRubberBall as? Entity & HasPhysics
        }
        
        private var currentState: State
        
        private var experienceNumber = 0
        
        private weak var observer: ExperienceControllerObserver?
        
        init(observer: ExperienceControllerObserver) {
            currentState = .begin
            self.observer = observer
        }
        
        // MARK: - Accessable
        func collisionChange(first entityA: Entity, second entityB: Entity) {
            guard currentState.activeThrowingFrame else { return }
            
            func entityIsInPlayAndHasFallenOver(_ entity: Entity) -> Bool {
                if bikesInPlay.contains(entity), entity.convert(normal: [0, 1, 0], to: nil).y < settings.pinTipThreshold {
                    transition(to: .frameComplete(struckBike: entity))
                    return true
                } else {
                    return false
                }
            }
            
            let aPinFellOver = entityIsInPlayAndHasFallenOver(entityA) || entityIsInPlayAndHasFallenOver(entityB)
            
            if !aPinFellOver && currentState == .ballInMotion {
                let velocity = ball?.physicsMotion?.linearVelocity ?? [0,0,0]
                if simd_norm_inf(velocity) < 0.01 {
                    transition(to: .ballAtRest)
                }
            }
        }
        
        // MARK: - Private
        private func completeThrowingFrame() {
//            guard currentState.activeThrowingFrame else { return }
//            let struckBike = experienceAnchor.allBikes.count - bikesInPlay.count
//            self.transition(to: .frameComplete(struckBike: struckBike))
//            let struckBike = experienceAnchor
        }
        
        private func transition(to state: State) {
            guard state != currentState else { return }
            
            func transitionToAppStart() {
                Cortina.loadSceneAsync { [weak self] result in
                    switch result {
                    case .success(let scene):
                        guard let self = self else { return }
                        
                        if self.experienceAnchor == nil {
                            self.experienceAnchor = scene
                            self.observer?.experienceControllerContentDidLoad(self)
                        }
                        
                        if case let .waitingForContent(nextState) = self.currentState {
                            self.transition(to: nextState)
                        }
                    case .failure(let error):
                        print("Failed to load the experience due to: \(error.localizedDescription)")
                    }
                }
            }
            
            func transitionToMenu() {
                observer?.experienceControllerReadyForPlayer(self)
            }
            
            func transitionToPlacingContent() {
                observer?.experienceControllerReadyForContentPlacement(self)
            }
            
            func transitionToReadyToThrow() {
                experienceNumber += 1
                if experienceAnchor == nil {
                    transition(to: .waitingForContent(nextState: .readyToThrow))
                } else {
                    observer?.experienceController(self, readyForPlayerToThrowBall: experienceNumber)
                }
            }
            
            func transitionToBallAtRest() {
                let currentExperience = experienceNumber
                DispatchQueue.main.asyncAfter(deadline: .now() + settings.frameSettleDelay) {
                    guard currentExperience == self.experienceNumber else { return }
                    self.completeThrowingFrame()
                }
            }
            
            func transitionToFrameComplete(striking struckBike: Entity) {
                observer?.experienceController(self, completedThrowingFrameWithStruckBike: struckBike)
            }
            
            func transitionToWatingForContent(for nextState: State) {
                if experienceAnchor != nil {
                    transition(to: nextState)
                }
            }
            
            currentState = state
            
            switch state {
            case .begin: break
            case .appStart: transitionToAppStart()
            case .menu: transitionToMenu()
            case .placingContent: transitionToPlacingContent()
            case .readyToThrow: transitionToReadyToThrow()
            case .ballInMotion: break
            case .ballAtRest: transitionToBallAtRest()
            case let .frameComplete(bike): transitionToFrameComplete(striking: bike)
            case let .waitingForContent(nextState): transitionToWatingForContent(for: nextState)
            }
        }
    }
}

extension Cortina.Scene {
    var allBikes: [Entity?] {
        return [
            bike1,
            bike2,
            bike3
        ]
    }
}

fileprivate extension Cortina.ExperienceController.State {
    var activeThrowingFrame: Bool {
        self == .ballInMotion ||
        self == .ballAtRest
    }
}
