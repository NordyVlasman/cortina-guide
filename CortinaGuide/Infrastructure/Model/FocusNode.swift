//
//  FocusNode.swift
//  CortinaGuide
//
//  Created by Nordy Vlasman on 22/12/2021.
//

import ARKit

class FocusNodeHelper {
    func focusNodeURLFor(name: String) -> URL? {
        return Bundle(for: type(of: self)).url(forResource: name, withExtension: "scn", subdirectory: "ARBase.scnassets")
    }
}

class FocusNode: SCNNode {
    
    private var isUsingBillboard: Bool = false
    private var anchorsOfVisitedPlanes: Set<ARAnchor> = []
    private var recentFocusSquarePositions: [SIMD3<Float>] = []
    private(set) var recentFocusSquareAlignments: [ARPlaneAnchor.Alignment] = []
    private(set) var currentPlaneAnchor: ARPlaneAnchor?
    
    private struct Constant {
        struct defaultFocusNodePaths {
            static let ArtSCNAssetsName = "ARBase.scnassets"
            static let NotFoundPath = FocusNodeHelper().focusNodeURLFor(name: "defaultFocusNotFound")
            static let EstimatedPath = FocusNodeHelper().focusNodeURLFor(name: "defaultFocusEstimated")
            static let ExistingPath = FocusNodeHelper().focusNodeURLFor(name: "defaultFocusExisting")
        }
        
        struct key {
            struct pulsing {
                static let fadeAnimation = "pulsingFadeAnimation"
                static let scaleAnimation = "pulsingScaleAnimation"
            }
            static let opacity = "opacity"
            static let transform = "transform"
        }
    }
    
    enum State: Equatable {
        case initializing
        case detecting(raycastResult: ARRaycastResult, camera: ARCamera?)
    }
    
    enum StatusAppearance {
        case complete
        case partial
        case none
    }
    
    var state: State = .initializing {
        didSet {
            guard state != oldValue else { return }

            switch state {
            case .initializing:
                
                if isUsingBillboard {
                    displayAsBillboard()
                }
                break

            case let .detecting(raycastResult, camera):
                if let planeAnchor = raycastResult.anchor as? ARPlaneAnchor {
                    anchorsOfVisitedPlanes.insert(planeAnchor)
                    currentPlaneAnchor = planeAnchor
                } else {
                    currentPlaneAnchor = nil
                }
                let position = raycastResult.worldTransform.translation
                recentFocusSquarePositions.append(position)
                updateTranform(for: position, raycastResult: raycastResult, camera: camera)
            }
        }
    }
    
    var lastPosition: SIMD3<Float>? {
        switch state {
        case .initializing: return nil
        case .detecting(let hitTestResult, _): return hitTestResult.worldTransform.translation
        }
    }
    
    // MARK: - Public
    func hide() {
    }
    
    func unhide() {
    }
    
    // MARK: - Private
    private func displayAsBillboard() {
        simdTransform = matrix_identity_float4x4
        eulerAngles.x = .pi / 2
        simdPosition = SIMD3<Float>(0, 0, -0.8)
        unhide()
    }
    
    // MARK: - Private helpers
    private func updateTranform(for position: SIMD3<Float>, raycastResult: ARRaycastResult, camera: ARCamera?) {
        
    }
}
