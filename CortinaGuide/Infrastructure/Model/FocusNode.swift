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
    private var isChangingAlignment: Bool = false
    private var anchorsOfVisitedPlanes: Set<ARAnchor> = []
    private var recentFocusSquarePositions: [SIMD3<Float>] = []
    private(set) var recentFocusSquareAlignments: [ARPlaneAnchor.Alignment] = []
    private(set) var currentPlaneAnchor: ARPlaneAnchor?
    
    var currentAlignment: ARPlaneAnchor.Alignment?
    
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
    
    // MARK: - Init / Deinit
    
    override init() {
        super.init()
        setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }
    
    // MARK: - Setup
    func setup(withNotFoundNamed notFoundNamed: String, estimatedNamed: String, existingNamed: String) {
        
    }
    
    func setup(withNotFoundNode notFoundNode: SCNNode? = nil, estimatedNode: SCNNode? = nil, existingNode: SCNNode? = nil) {
        
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
        recentFocusSquarePositions = Array(recentFocusSquarePositions.suffix(10))
        
        let average = recentFocusSquarePositions.reduce(SIMD3<Float>(repeating: 0), { $0 + $1 }) / Float(recentFocusSquarePositions.count)
        self.simdPosition   = average
        self.simdScale      = SIMD3<Float>(repeating: scaleBasedOnDistance(camera: camera))
        
        guard let camera = camera else {
            return
        }

        let tilt = abs(camera.eulerAngles.x)
        let firstThreshold: Float = .pi / 2 * 0.65
        let secondThreshold: Float = .pi / 2 * 0.75
        let yaw = atan2f(camera.transform.columns.0.x, camera.transform.columns.1.x)

        var angle: Float = 0
        
        switch tilt {
        case 0..<firstThreshold:
            angle = camera.eulerAngles.y
        case firstThreshold ..< secondThreshold:
            let relativeInRange = abs((tilt - firstThreshold) / (secondThreshold - firstThreshold))
            let normalizedY = normalize(camera.eulerAngles.y, forMinimalRotationTo: yaw)
            angle = normalizedY * (1 - relativeInRange) + yaw * relativeInRange
        default:
            angle = yaw
        }
        
        if state != .initializing {
            updateAlignment(for: raycastResult, yRotationAngle: angle)
        }
    }
    
    private func updateAlignment(for raycastResult: ARRaycastResult, yRotationAngle angle: Float) {
        if isChangingAlignment { return }
        
        var shouldAnimateAlignmentChange = false
        
        let tmpNode = SCNNode()
        tmpNode.simdRotation = SIMD4<Float>(0, 1, 0, angle)
        
        var alignment: ARPlaneAnchor.Alignment?
        
        if let planeAnchor = raycastResult.anchor as? ARPlaneAnchor {
            alignment = planeAnchor.alignment
        }
        
        if alignment != nil {
            recentFocusSquareAlignments.append(alignment!)
        }
        
        recentFocusSquareAlignments = Array(recentFocusSquareAlignments.suffix(20))
        
        let horizontalHistory   = recentFocusSquareAlignments.filter({ $0 == .horizontal }).count
        let verticalHistory     = recentFocusSquareAlignments.filter({ $0 == .vertical }).count
        
        if alignment == .horizontal && horizontalHistory > 15 || alignment == .vertical && verticalHistory > 10 || raycastResult.anchor is ARPlaneAnchor {
            if alignment != currentAlignment {
                shouldAnimateAlignmentChange = true
                currentAlignment = alignment
                recentFocusSquareAlignments.removeAll()
            }
        } else {
            alignment = currentAlignment
            return
        }
        
        if alignment == .vertical {
            tmpNode.simdOrientation = raycastResult.worldTransform.orientation
            shouldAnimateAlignmentChange = true
        }
        
        if shouldAnimateAlignmentChange {
            performAlignmentAnimation(to: tmpNode.simdOrientation)
        } else {
            simdOrientation = tmpNode.simdOrientation
        }
    }
    
    private func performAlignmentAnimation(to newOrientation: simd_quatf) {
        isChangingAlignment = true
        SCNTransaction.begin()
        
        SCNTransaction.completionBlock = {
            self.isChangingAlignment = false
        }
        
        SCNTransaction.animationDuration = 0.5
        SCNTransaction.animationTimingFunction = .easeInEaseOut
        
        simdOrientation = newOrientation
        
        SCNTransaction.commit()
    }
    
    private func scaleBasedOnDistance(camera: ARCamera?) -> Float {
        guard let camera = camera else {
            return 1.0
        }
        
        let distanceFromCamera = simd_length(simdWorldPosition - camera.transform.translation)
        if distanceFromCamera < 0.7 {
            return distanceFromCamera / 0.7
        } else {
            return 0.25 * distanceFromCamera + 0.825
        }
    }
    
    private func normalize(_ angle: Float, forMinimalRotationTo ref: Float) -> Float {
        var normalized = angle
        while abs(normalized - ref) > .pi / 4 {
            if angle > ref {
                normalized -= .pi / 2
            } else {
                normalized += .pi / 2
            }
        }
        return normalized
    }
}
