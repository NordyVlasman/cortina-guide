//
//  BikeEntity.swift
//  CortinaGuide
//
//  Created by Nordy Vlasman on 03/01/2022.
//

import Foundation
import Combine
import RealityKit

final class BikeEntity: Entity, HasModel, HasPhysics, HasUprightStatus {
    
    static let shape = ShapeResource.generateSphere(radius: 20)
    
    private(set) static var bikeEntity: BikeEntity?
    
    static let bikeUprightDefaultParameters = UprightStatusParameters(
        framesRequiredForStill: 3,
        linearVelocityThreshold: 0.01,
        angularVelocityThreshold: 0.01,
        framesRequiredForUprightNoChange: 3,
        uprightPositionYThreshold: 0.1,
        uprightNormalYThreshold: 0.1,
        belowSurface: -0.01,
        continuousState: false
    )
    
    static func loadAsync() -> AnyPublisher<BikeEntity, Error> {
        return Entity.loadAsync(named: Asset.name(for: .bike))
            .tryMap { entity -> BikeEntity in
                let pipeline = Pipeline()
                try pipeline.process(root: entity)
                let bikeEntity = BikeEntity()
                bikeEntity.addChild(entity)
                bikeEntity.configure()
                BikeEntity.bikeEntity = bikeEntity
                return bikeEntity
            }
            .eraseToAnyPublisher()
    }
        
    private func configure() {
        name = "Bike"
        
        physicsBody = createPhysicsBody()
        physicsMotion = .init()
        
        transform.translation = [0.0, PhysicsConstants.bikeScale, 0.0]
        transform.scale = SIMD3(repeating: PhysicsConstants.bikeScale)
    }
    
    func createPhysicsBody(
        mass: Float = PhysicsConstants.bikeMass,
        staticFriction: Float = PhysicsConstants.bikeStaticFriction,
        kineticFriction: Float = PhysicsConstants.bikeKineticFriction,
        restitution: Float = PhysicsConstants.bikeRestitution) -> PhysicsBodyComponent {
        
            var physicsBody = PhysicsBodyComponent(shapes: [BikeEntity.shape], mass: mass)
            physicsBody.material = .generate(staticFriction: staticFriction, dynamicFriction: kineticFriction, restitution: restitution)
            physicsBody.mode = .dynamic
            return physicsBody
    }
}
