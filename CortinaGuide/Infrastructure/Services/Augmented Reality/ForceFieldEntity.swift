//
//  ForceFieldEntity.swift
//  CortinaGuide
//
//  Created by Nordy Vlasman on 01/01/2022.
//

import Foundation
import RealityKit

protocol IsForceFieldOwner where Self: Entity {
    var forceFieldEntity: ForceFieldEntity? { get }
}

class ForceFieldEntity: Entity, HasCollision, HasPhysics, HasCollisionSize {
    
}
