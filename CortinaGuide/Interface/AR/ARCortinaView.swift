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

enum CollisionGroups: String, CaseIterable {
    case bike, bigRubberBall, ground
}

class ARCortinaView: ARView, ARSessionDelegate, HasCollisionGroups, ARCoachingOverlayViewDelegate {
    typealias CollisionGroupsEnum = CollisionGroups
    
    var cortinaScene: Cortina.Scene!
    var cameraAnchor = AnchorEntity(.camera)
    
    private var collisionSubscriptions = [Cancellable]()
    
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
    var arCoachingOverlayView: ARCoachingOverlayView?
    
    let cortinaRenderOptions: ARView.RenderOptions = [
        .disableMotionBlur,
        .disableCameraGrain
    ]
        
    func setup() {
        arCoachingOverlayView = ARCoachingOverlayView(frame: frame)
        arView.renderOptions = cortinaRenderOptions
        loadScene()
        
        scene.addAnchor(cameraAnchor)
        
        prepareView()
        
        if ARWorldTrackingConfiguration.supportsSceneReconstruction(.mesh) {
            setupLidar()
        } else {
            setupDefault()
        }
    }
    
    // MARK: - Publics
    func addCollisionListenings(onEntity entity: Entity & HasCollision) {
        collisionSubscriptions.append(self.scene.subscribe(to: CollisionEvents.Began.self, on: entity) { event in
            print(event.entityA.name, "collided with", event.entityB.name)
        })
    }
    
    // MARK: - Privates
    private func prepareView() {
        guard let arCoachingOverlayView = arCoachingOverlayView else {
            return
        }
        arView.addSubview(arCoachingOverlayView)

        NSLayoutConstraint.activate([
            arCoachingOverlayView.topAnchor.constraint(
                equalTo: arView.topAnchor
            ),
            arCoachingOverlayView.leadingAnchor.constraint(
                equalTo: arView.leadingAnchor
            ),
            arCoachingOverlayView.trailingAnchor.constraint(
                equalTo: arView.trailingAnchor
            ),
        ])
        
        arCoachingOverlayView.goal = .horizontalPlane
        
    }
    
    private func loadScene() {
        Cortina.loadSceneAsync(completion: {[weak self] result in
            switch result {
            case .failure(let error):
                print(error.localizedDescription)
            case .success(let scene):
                self?.cortinaScene = scene
                self?.scene.addAnchor(scene)
                self?.sceneDidLoad()
            }
        })
    }
    
    private func setupLidar() {
        let configuration = ARWorldTrackingConfiguration()
        configuration.planeDetection = .horizontal
        configuration.sceneReconstruction = .mesh
        session.run(configuration)
        arCoachingOverlayView?.session = session
        environment.sceneUnderstanding.options.insert(.physics)
    }
    
    private func setupDefault() {
        let configuration = ARWorldTrackingConfiguration()
        configuration.planeDetection = .horizontal
        session.run(configuration)
        arCoachingOverlayView?.session = session
        environment.sceneUnderstanding.options.insert(.physics)
    }
    
    private func sceneDidLoad() {
        guard let groundPlane = cortinaScene.findEntity(named: "Ground Plane") else { return }
        
        setNewCollisionFilter(thisEntity: groundPlane, belongsToGroup: .ground, andCanCollideWith: [.bike, .bigRubberBall, .ground])
        setNewCollisionFilter(thisEntity: cortinaScene.bike!, belongsToGroup: .bike, andCanCollideWith: [.bike, .bigRubberBall, .ground])
        setNewCollisionFilter(thisEntity: cortinaScene.bigRubberBall!, belongsToGroup: .bigRubberBall, andCanCollideWith: [.ground, .bike])
        addCollisionListenings(onEntity: cortinaScene.bigRubberBall as! Entity & HasCollision)
        
        if ARWorldTrackingConfiguration.supportsSceneReconstruction(.mesh) {
            DispatchQueue.main.asyncAfter(deadline: .now() + 5) {
                let sceneEntities = [self.cortinaScene.bike!, self.cortinaScene.bigRubberBall!]
                sceneEntities.forEach { entity in
                    self.addCollisionWithLiDARMesh(on: entity)
                }
            }
        }
    }
}
