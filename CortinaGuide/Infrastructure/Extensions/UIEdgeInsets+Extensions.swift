//
//  UIEdgeInsets+Convenience.swift
//  CortinaGuide
//
//  Created by Nordy Vlasman on 21/12/2021.
//

import UIKit

extension UIEdgeInsets {

    static func left(_ value: CGFloat) -> UIEdgeInsets {
        UIEdgeInsets(top: 0, left: value, bottom: 0, right: 0)
    }

    static func right(_ value: CGFloat) -> UIEdgeInsets {
        UIEdgeInsets(top: 0, left: 0, bottom: 0, right: value)
    }

    static func top(_ value: CGFloat) -> UIEdgeInsets {
        UIEdgeInsets(top: value, left: 0, bottom: 0, right: 0)
    }

    static func bottom(_ value: CGFloat) -> UIEdgeInsets {
        UIEdgeInsets(top: 0, left: 0, bottom: value, right: 0)
    }

    static func leftRight(_ value: CGFloat) -> UIEdgeInsets {
        UIEdgeInsets(top: 0, left: value, bottom: 0, right: value)
    }

    static func topBottom(_ value: CGFloat) -> UIEdgeInsets {
        UIEdgeInsets(top: value, left: 0, bottom: value, right: 0)
    }

    static func all(_ value: CGFloat) -> UIEdgeInsets {
        UIEdgeInsets(top: value, left: value, bottom: value, right: value)
    }

    public static func + (lhs: UIEdgeInsets, rhs: UIEdgeInsets) -> UIEdgeInsets {
        UIEdgeInsets(
            top: lhs.top + rhs.top,
            left: lhs.left + rhs.left,
            bottom: lhs.bottom + rhs.bottom,
            right: lhs.right + rhs.right)
    }
}
