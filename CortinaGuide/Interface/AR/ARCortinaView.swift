//
//  ARCortinaVie.swift
//  CortinaGuide
//
//  Created by Nordy Vlasman on 23/12/2021.
//

import Foundation
import RealityKit
import ARKit
import Combine

class Settings {
//
}

class ARCortinaView: ARView, ARSessionDelegate {
    
    private var cancellable: AnyCancellable?
    
    init(frame: CGRect, settings: Settings) {
        super.init(frame: frame)
    }
    
    required init?(coder decoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    required init(frame frameRect: CGRect) {
        fatalError("init(frame:) has not been implemented")
    }
    
    var arView: ARView { return self }
   
    lazy var bikeAnchor: AnchorEntity = {
        let bikeAnchor = AnchorEntity()
        scene.addAnchor(bikeAnchor)
        return bikeAnchor
    }()
        
    func setup() {
        let arConfig = ARWorldTrackingConfiguration()
        arView.session.run(arConfig)
        asyncLoadModelEntity()
    }
    
    func asyncLoadModelEntity() {
        let filename = "export.usdc"
        
        self.cancellable = ModelEntity.loadModelAsync(named: filename)
            .sink(receiveCompletion: { loadCompletion in
                switch loadCompletion {
                case .failure(let error): print("Unable to load modelEntity for \(filename). Error: \(error.localizedDescription)")
                case .finished:
                    break
                }
            }, receiveValue: { modelEntity in
                let entity = modelEntity.clone(recursive: true)
                entity.generateCollisionShapes(recursive: true)
    
                self.bikeAnchor.addChild(entity)
            
                
                
                self.scene.addAnchor(self.bikeAnchor)
                self.arView.installGestures(for: entity)
                
            })
    }
}
