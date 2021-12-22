//
//  ScenekitAnimator.swift
//  CortinaGuide
//
//  Created by Nordy Vlasman on 22/12/2021.
//

import SceneKit


class SceneKitAnimator {

    var completed: (() -> Void)?

    @discardableResult
    /// A block object wrapping animations and combining scene graph changes into atomic updates.
    ///
    /// - Parameters:
    ///   - duration: The total duration of the animations, measured in seconds. If you specify a negative value or 0, the changes are made without animating them.
    ///   - timingFunction: A function that defines the pacing of an animation as a timing curve.
    ///   - animated: A boolean value that determines if this animation expected to perform or not. The defualt value of this property is true.
    ///   - animations: A block object containing the changes to commit to the views. This is where you programmatically change any animatable properties of the views in your view hierarchy. This block takes no parameters and has no return value. This parameter must not be NULL.
    ///   - completion: A block object to be executed when the animation sequence ends. This block has no return value and takes a single Boolean argument that indicates whether or not the animations actually finished before the completion handler was called. If the duration of the animation is 0, this block is performed at the beginning of the next run loop cycle. This parameter may be NULL.
    /// - Returns: The object wrapping SceneKit animation.
    class func animateWithDuration(duration: TimeInterval,
                                        timingFunction: CAMediaTimingFunction = .default,
                                        animated: Bool = true,
                                        animations: (() -> Void),
                                        completion: (() -> Void)? = nil) -> SceneKitAnimator{
        let promise = SceneKitAnimator()
        SCNTransaction.begin()
        SCNTransaction.completionBlock = {
            completion?()
            promise.completed?()
        }
        SCNTransaction.animationTimingFunction = timingFunction
        SCNTransaction.animationDuration = duration
        animations()
        SCNTransaction.commit()
        return promise
    }

    @discardableResult
    /// A block object wrapping animations and combining scene graph changes into atomic updates.
    ///
    /// - Parameters:
    ///   - duration: The total duration of the animations, measured in seconds. If you specify a negative value or 0, the changes are made without animating them.
    ///   - timingFunction: A function that defines the pacing of an animation as a timing curve.
    ///   - animated: A boolean value that determines if this animation expected to perform or not. The defualt value of this property is true.
    ///   - animations: A block object containing the changes to commit to the views. This is where you programmatically change any animatable properties of the views in your view hierarchy. This block takes no parameters and has no return value. This parameter must not be NULL.
    ///   - completion: A block object to be executed when the animation sequence ends. This block has no return value and takes a single Boolean argument that indicates whether or not the animations actually finished before the completion handler was called. If the duration of the animation is 0, this block is performed at the beginning of the next run loop cycle. This parameter may be NULL.
    /// - Returns: The object wrapping SceneKit animation.
    func thenAnimateWithDuration(duration: TimeInterval,
                                    timingFunction: CAMediaTimingFunction = .default,
                                    animated: Bool = true,
                                    animations: @escaping (() -> Void),
                                    completion: (() -> Void)? = nil) -> SceneKitAnimator {
        let animator = SceneKitAnimator()
        completed = {
            SceneKitAnimator.animateWithDuration(duration: duration,
                                                 timingFunction: timingFunction,
                                                 animated: animated,
                                                 animations: animations,
                                                 completion: {
                                                    completion?()
                                                    animator.completed?()
            })
        }
        return animator
    }

}
