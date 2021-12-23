//
//  ARCortinaVie.swift
//  CortinaGuide
//
//  Created by Nordy Vlasman on 23/12/2021.
//

import Foundation
import RealityKit
import ARKit

class Settings {
//
}

class ARCortinaView: ARView, ARSessionDelegate {
    
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
    func setup() {
        if let arScene = try? Cortina.loadBike() {
            print("Bike loaded \(arScene.name)")
            arView.scene.anchors.append(arScene)
        }
        let arConfig = ARWorldTrackingConfiguration()
        arView.session.run(arConfig)
    }
}
