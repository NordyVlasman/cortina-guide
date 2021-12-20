//
//  Bindable.swift
//  CortinaGuide
//
//  Created by Nordy Vlasman on 20/12/2021.
//

import Foundation

/// Provides the ability to observe value changes with a closure.
///
/// # Example use:
/// ````
/// @Bindable private(set) var title = "Add Contact"
/// $title.binding = { [weak self] in self?.titleLabel.text = $0 }
/// ````
///
/// - Tag: Bindable
@propertyWrapper class Bindable<T> {

    var value: T
    private(set) lazy var projectedValue = Binder { [unowned self] in self.value }
    
    init(wrappedValue: T) {

        value = wrappedValue
    }
    
    var wrappedValue: T {
        get {
            return value
        }
        
        set {
            value = newValue
            projectedValue.binding?(newValue)
        }
    }
    
    // Use a nested class to store the binding closure. This way a @Bindable property can be declared immutable and still have a mutable value for the closure.
    class Binder {

        private var valueProvider: () -> T
        var binding: ((T) -> Void)? { didSet { binding?(valueProvider()) } }
        
        init(valueProvider: @escaping () -> T) {
            
            self.valueProvider = valueProvider
        }
    }
}
