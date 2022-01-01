//
//  BikeEntity.swift
//  CortinaGuide
//
//  Created by Nordy Vlasman on 31/12/2021.
//

import Foundation
import RealityKit

struct BikeComponent: Component {}

extension BikeComponent: Codable {}

protocol HasBike where Self: HasStandupright {}

extension HasBike {
    var bikeComponent: BikeComponent {
        get {
            return components[BikeComponent.self] ?? BikeComponent()
        }
        set {
            components[BikeComponent.self] = newValue
        }
    }
}

class BikeEntity: HasPhysics, HasBike, HasStandupright, HasCollisionSize {
    
}
