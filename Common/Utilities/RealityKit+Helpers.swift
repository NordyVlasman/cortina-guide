//
//  RealityKit+Helpers.swift
//  CortinaGuide
//
//  Created by Nordy Vlasman on 03/01/2022.
//

import RealityKit
import Combine

// MARK: - Scene Helpers

// MARK: - Entity Helpers

extension Entity {
    func forEachInHierarchy(depth: Int = 0, closure: (Entity, Int) throws -> Void) rethrows {
        try closure(self, depth)
        for child in children {
            try child.forEachInHierarchy(depth: depth + 1, closure: closure)
        }
    }
}

extension Entity {
    
    func forward(relativeTo: Entity?) -> SIMD3<Float> {
        let rotation = orientation(relativeTo: relativeTo)
        return rotation.act([0, 0, -1])
    }
}

/**
 Asynchronous Entity load support
 */
protocol EntityToLoad {
    associatedtype Key: OptionSet
    var key: Key { get set }
    var filename: String { get }
}

extension Entity {
    
    static func loadEntitiesAsync<EntityToLoadType>(_ entitiesToLoad: [EntityToLoadType]) -> AnyPublisher<[EntityToLoadType.Key: Entity], Never> where EntityToLoadType: EntityToLoad {
        
        let loadRequests = entitiesToLoad.map { entityToLoad in
            Entity.loadAsync(named: entityToLoad.filename)
                .assertNoFailure()
                .map { (entityToLoad, $0 ) }
        }
        
        let publisher = Publishers.Sequence(sequence: loadRequests)
            .flatMap { $0 }
            .collect()
            .map { publisherOfEntitiesToLoad -> [EntityToLoadType.Key: Entity] in
                var dictionary = [EntityToLoadType.Key: Entity]()
                publisherOfEntitiesToLoad.forEach {
                    dictionary[$0.0.key] = $0.1
                }
                return dictionary
            }
            .eraseToAnyPublisher()
        
        return publisher
    }
}
