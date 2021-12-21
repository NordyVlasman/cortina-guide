//
//  UIDevice+Extensions.swift
//  CortinaGuide
//
//  Created by Nordy Vlasman on 21/12/2021.
//

import UIKit

extension UIDevice {
    /// Is this a device with a smaller screen? (4" screen)
    var isSmallScreen: Bool {

        return UIScreen.main.nativeBounds.height <= 1136
    }

    var hasNotch: Bool {
        let bottom = UIApplication.shared.keyWindow?.safeAreaInsets.bottom ?? 0
        return bottom > 0
    }
}
