//
//  VirtualObjectLoader.swift
//  CortinaGuide
//
//  Created by Nordy Vlasman on 22/12/2021.
//

import Foundation

class VirtualObjectLoader: NSObject {
    
    public private(set) var objects: [VirtualObject] = []
    public private(set) var isLoading = false
    
    // MARK: - Loading object
    
    func loadVirtualObject(_ object: VirtualObject, loadedHandler: ((VirtualObject) -> Void)? = nil) {
        isLoading = true
        objects.append(object)
        
        DispatchQueue.global(qos: .userInitiated).async {
            object.load()
            self.isLoading = false
            DispatchQueue.main.async {
                loadedHandler?(object)
            }
        }
    }
    
    // MARK: - Remove Objects
    
    func removeAllVirtualObjects() {
        for index in objects.indices.reversed() {
            removeVirtualObject(at: index)
        }
    }
    
    func removeVirtualObject(at index: Int) {
        guard objects.indices.contains(index) else { return }
        
        objects[index].removeFromParentNode()
        objects.remove(at: index)
    }
    
    func remove(_ object: VirtualObject) {
        guard objects.contains(object) else { return }
        
        object.removeFromParentNode()
        objects.remove(at: objects.firstIndex(of: object)!)
    }
}
