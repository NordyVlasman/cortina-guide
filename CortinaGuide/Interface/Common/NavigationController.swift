//
//  NavigationController.swift
//  CortinaGuide
//
//  Created by Nordy Vlasman on 20/12/2021.
//

import UIKit

class NavigationController: UINavigationController {
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        if #available(iOS 13.0, *) {
            return topViewController?.preferredStatusBarStyle ?? .darkContent
        } else {
            return topViewController?.preferredStatusBarStyle ?? .default
        }
    }
    
}
