//
//  ARVirtualObject.swift
//  CortinaGuide
//
//  Created by Nordy Vlasman on 22/12/2021.
//

import ARKit

class VirtualObject: SCNNode {
    typealias VoidBlock = () -> Void
    
    enum LoadingType {
        case none
        case refferenceNode(SCNReferenceNode)
    }
    
    var anchor: ARAnchor?
    
    private(set) var isEditing: Bool = false
    
    var allowedAlignments: [ARPlaneAnchor.Alignment] = [.horizontal]
    
    var scaleRange: ClosedRange<Float>?
    
    var snapScalingFactors: [Float] = [1.0]
    
    var snapScalingTreshold: Float = 0.1
    
    var temporarlyBeginRotationFactor: Float = 0
    
    var temporarlyBeginPinchFactor: Float = 1
    
    private(set) var isLoaded: Bool
    
    var loadingType: LoadingType = .none
    
    var currentAlignment = ARPlaneAnchor.Alignment.horizontal
    
    var isChangingAlignment = false
    
    var rotationWhenAlginedHorizontally: Float = 0
    
    var animationForVirtualObjectRemoving: ((VirtualObject, @escaping VoidBlock) -> Void)?
    
    /// Node Graphs
    let yRotationControllerNode = SCNNode()
    let scaleControllerNode = SCNNode()
    let headNode = SCNNode()
    let pivotScaleControllerNode = SCNNode()
    let pivotYRotationControllerNode = SCNNode()
    
    /// Recent virtual object stuff
    private var recentVirtualObjectDistances: [Float] = []
    var startingDragVector: SCNVector3 = SCNVector3Zero
    var startingObjectVector: SCNVector3 = SCNVector3Zero
    var lastPanGesture: UIPanGestureRecognizer?
    
    private(set) var nodeScale: Float = 1 {
        didSet {
            let scaleFactor = nodeScale
            scaleControllerNode.scale = SCNVector3Make(scaleFactor, scaleFactor, scaleFactor)
        }
    }
    
    var defaultScale: Float = 1
    
    private var _virtualScale: Float = 1
    
    var virtualScale: Float {
        get {
            return _virtualScale
        } set {
            let scale: Float
            if let scaleRange = scaleRange {
                scale = max(scaleRange.lowerBound, min(scaleRange.upperBound, newValue))
                
                if _virtualScale != scaleRange.lowerBound && scale == scaleRange.lowerBound {
                    // TODO: = Change scale
                } else if (_virtualScale != scaleRange.upperBound && scale == scaleRange.upperBound) {
                    // TODO: = SCALE TO BOUND
                }
            } else {
                scale = newValue
            }
            
            let snapScalingFactor = snapScalingFactors.first {
                let begin = $0 * (1 - self.snapScalingTreshold)
                let end = $0 * (1 + self.snapScalingTreshold)
                return (begin...end).contains(scale)
            }
            
            if let currentSnapScalingFactor = snapScalingFactor, scale != currentSnapScalingFactor {
                if _virtualScale != currentSnapScalingFactor {
                    // TODO: = DidSnapToScalingFactor
                    _virtualScale = currentSnapScalingFactor
                }
            } else {
                _virtualScale = scale
            }
            
            nodeScale = virtualScale
        }
    }
    
    var virtualRotation: Float = 0 {
        didSet {
            yRotationControllerNode.eulerAngles.y = virtualRotation
        }
    }
    
    var contentNode: SCNNode? {
        didSet {
            oldValue?.removeFromParentNode()
            if let containNode = contentNode {
                containNode.removeFromParentNode()
                headNode.addChildNode(containNode)
                
                containNode.position.y = Float.random(in: -0.00025 ..< 0.00025)
            }
        }
    }
    
    var virtualTransform: SCNMatrix4 {
        get {
            return self.transform
        } set {
            self.transform = newValue
        }
    }
    
    
    // MARK: - Init / Deinit
    public override init() {
        isLoaded = false
        super.init()
        setupNodeStructure()
    }
    
    /// Initializes and returns Virtual Object
    ///
    /// - Parameters:
    ///   - containNode: Loaded SCNNode Object
    ///   - allowAlignment: Allowed alignments
    public init(containNode: SCNNode, allowedAlignments: [ARPlaneAnchor.Alignment] = [.horizontal]) {
        isLoaded = true
        super.init()
        self.allowedAlignments = allowedAlignments
        setupNodeStructure()
        self.contentNode = containNode
        headNode.addChildNode(containNode)
    }
    
    /// Initializers and returns Virtual Object
    ///
    /// - Parameters:
    ///   - containNode: Loaded SCNNode object
    ///   - allowedAlignment: Allowed alignments
    public init(scene: SCNScene, allowedAlignments: [ARPlaneAnchor.Alignment] = [.horizontal]) {
        isLoaded = true
        super.init()
        self.allowedAlignments = allowedAlignments
        setupNodeStructure()
        let node = scene.rootNode.clone()
        self.contentNode = node
        headNode.addChildNode(node)
    }
    
    /// Initializes by SCNReferenceNode and returns Virtual Object
    ///
    /// - Parameters:
    ///   - refferenceNode: SCNReferenceNode object
    ///   - allowedAlignemnts: Alignment that allows virtual objects to be placed.
    public init(refferenceNode: SCNReferenceNode, allowedAlignments: [ARPlaneAnchor.Alignment] = [.horizontal]) {
        isLoaded = false
        super.init()
        self.allowedAlignments = allowedAlignments
        setupNodeStructure()
        self.loadingType = .refferenceNode(refferenceNode)
    }
    
    /// Initializes and returns Virtual Object
    ///
    /// - Parameters:
    ///   - coder: Coder for decoding object
    required init?(coder aDecoder: NSCoder) {
        isLoaded = false
        super.init(coder: aDecoder)
        setupNodeStructure()
    }
    
    deinit {
        loadingType = .none
    }
    
    // MARK: - Private
    
    private func setupNodeStructure() {
        yRotationControllerNode.name        = "yRotationControllerNode"
        pivotYRotationControllerNode.name   = "pivotYRotationControllerNode"
        scaleControllerNode.name            = "scaleControllerNode"
        pivotScaleControllerNode.name       = "pivotScaleControllerNode"
        headNode.name                       = "headNode"
        
        self.addChildNode(yRotationControllerNode)
        self.addChildNode(pivotYRotationControllerNode)
        self.addChildNode(scaleControllerNode)
        self.addChildNode(pivotScaleControllerNode)
        self.addChildNode(headNode)
    }
    
    private func load() {
        switch loadingType {
        case .refferenceNode(let sCNReferenceNode):
            sCNReferenceNode.load()
            contentNode = sCNReferenceNode
        default:
            break
        }
        loadingType = .none
    }
    
    // MARK: - Public
    
    func reset() {
        nodeScale = 1
        virtualScale = 1
        virtualRotation = 0
        
        transform                               = SCNMatrix4Identity
        scaleControllerNode.transform           = SCNMatrix4Identity
        pivotScaleControllerNode.transform      = SCNMatrix4Identity
        yRotationControllerNode.transform       = SCNMatrix4Identity
        pivotYRotationControllerNode.transform  = SCNMatrix4Identity
        headNode.transform                      = SCNMatrix4Identity
        
        loadingType = .none
    }
    
    /// Set scale to object from rotation gesture
    func setRotation(fromGesture gesture: UIRotationGestureRecognizer, inSceneView sceneView: SCNView) {
        if isEditing {
            switch gesture.state {
            case .began:
                temporarlyBeginRotationFactor = virtualRotation
            case .changed:
                virtualRotation = temporarlyBeginRotationFactor - Float(gesture.rotation)
            default:
                break
            }
        }
    }
    
    /// Set scale to object from pinch gesture
    func setPinch(fromGesture gesture: UIPinchGestureRecognizer, inSceneView sceneView: SCNView) {
        if isEditing {
            switch gesture.state {
            case .began:
                temporarlyBeginPinchFactor = virtualScale
            case .changed:
                virtualScale = temporarlyBeginPinchFactor * Float(gesture.scale)
            default:
                break
            }
        }
    }
    
    /// Set the transparency mode of the `content node`.
    ///
    /// - Parameter transparencyMode: The mode scenekit uses to calculate the opacity
    func setMaterialTransparencyMode(to transparencyMode: SCNTransparencyMode) {
        func updateMaterialTransparencyMode(for node: SCNNode) {
            for material in node.geometry?.materials ?? [] {
                material.transparencyMode = transparencyMode
            }
            
            for child in node.childNodes {
                updateMaterialTransparencyMode(for: child)
            }
        }
        
        guard let contentNode = contentNode else {
            return
        }

        updateMaterialTransparencyMode(for: contentNode)
    }
    
    func adjustOntoPlaneAnchor(_ anchor: ARPlaneAnchor, using node: SCNNode) {
        if !allowedAlignments.contains(anchor.alignment) && anchor.alignment != currentAlignment {
            return
        }
        
        let planePosition = node.convertPosition(position, to: parent)
        guard planePosition.y != 0 else { return }
        
        let tolerance: Float = 0.1
        let minX: Float = anchor.center.x - anchor.extent.x / 2 - anchor.extent.x * tolerance
        let maxX: Float = anchor.center.x + anchor.extent.x / 2 + anchor.extent.x * tolerance
        let minZ: Float = anchor.center.z - anchor.extent.z / 2 - anchor.extent.z * tolerance
        let maxZ: Float = anchor.center.z + anchor.extent.z / 2 + anchor.extent.z * tolerance
        
        guard (minX...maxX).contains(planePosition.x) && (minZ...maxZ).contains(planePosition.z) else { return }
    
        let verticalAllowance: Float = 0.05
        let epsilon: Float = 0.001
        let distanceToPlane = abs(planePosition.y)
        
        if distanceToPlane > epsilon && distanceToPlane < verticalAllowance {
            SceneKitAnimator.animateWithDuration(duration: CFTimeInterval(distanceToPlane * 500), timingFunction: .easeInOut, animations: {
                localTranslate(by: SCNVector3Make(0, -planePosition.y, 0))
                updateAlignment(to: anchor.alignment, transform: simdWorldTransform, allowAnimation: false)
            })
        }
    }
    
    func updateAlignment(to newAlignment: ARPlaneAnchor.Alignment, transform: float4x4, allowAnimation: Bool) {
        if isChangingAlignment { return }
        
        var newObjectRotation: Float?
        if newAlignment == .horizontal && currentAlignment != .horizontal {
            newObjectRotation = rotationWhenAlginedHorizontally
        } else if newAlignment != .horizontal && currentAlignment == .horizontal {
            newObjectRotation = 0.0001
        }
        
        currentAlignment = newAlignment
        
        SceneKitAnimator.animateWithDuration(duration: 0.35, timingFunction: .explodingEaseOut, animated: newAlignment != currentAlignment, animations: {
            isChangingAlignment = true
            simdTransform = transform
            simdTransform.translation = simdWorldPosition
            if newObjectRotation != nil {
                virtualRotation = newObjectRotation!
            }
        }, completion: {
            self.isChangingAlignment = false
        })
    }
    
    func setIsEditing(edit: Bool) {
        isEditing = edit
    }
    
    /**
     Set the objects position based on the provided position relative to the `cameraTransform`
     if `smoothMovement` is true, the new position will be averged with previous position to avoid large jumps.
     - Tag: - VirtualObjectSetPosition
     */
    public func setTransform(_ newTransform: float4x4, relativeTo cameraTransform: float4x4, smoothMovement: Bool, alignment: ARPlaneAnchor.Alignment, allowAnimation: Bool) {
        let cameraWorldPosition = cameraTransform.translation
        var positionOffsetFromCamera = newTransform.translation - cameraWorldPosition
        
        if simd_length(positionOffsetFromCamera) > 10 {
            positionOffsetFromCamera = simd_normalize(positionOffsetFromCamera)
            positionOffsetFromCamera *= 10
        }
        
        if smoothMovement {
            let hitTestResultDistance = simd_length(positionOffsetFromCamera)
            
            recentVirtualObjectDistances.append(hitTestResultDistance)
            recentVirtualObjectDistances = Array(recentVirtualObjectDistances.suffix(6))
            
            let averageDistance = recentVirtualObjectDistances.average!
            let averagedDistancePosition = simd_normalize(positionOffsetFromCamera) * averageDistance
            simdPosition = cameraWorldPosition + averagedDistancePosition
        } else {
            simdPosition = cameraWorldPosition + positionOffsetFromCamera
        }
        
        if currentAlignment != alignment {
            currentAlignment = alignment
            updateAlignment(to: alignment, transform: newTransform, allowAnimation: allowAnimation)
        }
    }
    
    func setAnimationForVirtualObjectRemoving(_ animation: @escaping ((VirtualObject, @escaping VoidBlock) -> Void)) {
        self.animationForVirtualObjectRemoving = animation
    }
    
    override func removeFromParentNode() {
        if let removeAnimation = animationForVirtualObjectRemoving, let _ = parent {
            removeAnimation(self, super.removeFromParentNode)
        } else {
            super.removeFromParentNode()
        }
    }
}

