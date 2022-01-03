//
//  RealityKit+Pipeline.swift
//  CortinaGuide
//
//  Created by Nordy Vlasman on 03/01/2022.
//

import RealityKit

extension Entity {

    // this is used for pins models only for SwiftStrike
    // Pins were created in meters per unit scale along
    // with collision meshes in Maya, so we check if
    // the usdz metersPerUnit was set to 0.01 by accident
    // and correct that here.
    func removeUSDZScaling() -> Bool {
        var modifiedFlag = false
        if scale == [0.01, 0.01, 0.01] {
            scale = [1, 1, 1]
            modifiedFlag = true
        }
        return modifiedFlag
    }

}

extension Entity {

    var rootEntity: Entity? {
        var current: Entity? = parent
        while current != nil {
            if current?.parent == nil {
                return current
            }
            current = current?.parent
        }
        return nil
    }

}

extension HasModel {

    func dumpMaterials() {
        forEachInHierarchy { (entity, _) in
            if let modelEntity = entity as? ModelEntity {
                modelEntity.dumpModelEntityMaterials()
            }
        }
    }

}

extension HasModel {

    func replaceMaterial(with newMaterial: Material?) {
        guard let modelComponent = components[ModelComponent.self] as? ModelComponent else {
            return
        }
        var newComponent = modelComponent
        if let newMaterial = newMaterial {
            newComponent.materials = [newMaterial]
        } else {
            newComponent.materials = []
        }
        components[ModelComponent.self] = newComponent
    }

}

