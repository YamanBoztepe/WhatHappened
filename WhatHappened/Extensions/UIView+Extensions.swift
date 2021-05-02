//
//  UIView+Extensions.swift
//  WhatHappened
//
//  Created by Yaman Boztepe on 23.04.2021.
//

import UIKit

struct AnchorConstraint {
    
    var top: NSLayoutConstraint?
    var bottom: NSLayoutConstraint?
    var leading: NSLayoutConstraint?
    var trailing: NSLayoutConstraint?
    var height: NSLayoutConstraint?
    var width: NSLayoutConstraint?
}

extension UIView {
    
    func anchor(top: NSLayoutYAxisAnchor?, bottom: NSLayoutYAxisAnchor?, leading: NSLayoutXAxisAnchor?, trailing: NSLayoutXAxisAnchor?, size: CGSize = .zero, padding: UIEdgeInsets = .zero) -> AnchorConstraint {
        
        translatesAutoresizingMaskIntoConstraints = false
        
        var anchorConstraint = AnchorConstraint()
        
        if let top = top {
            anchorConstraint.top = topAnchor.constraint(equalTo: top, constant: padding.top)
        }
        
        if let bottom = bottom {
            anchorConstraint.bottom = bottomAnchor.constraint(equalTo: bottom, constant: -padding.bottom)
        }
        
        if let leading = leading {
            anchorConstraint.leading = leadingAnchor.constraint(equalTo: leading, constant: padding.left)
        }
        
        if let trailing = trailing {
            anchorConstraint.trailing = trailingAnchor.constraint(equalTo: trailing, constant: -padding.right)
        }
        
        if size.width != 0 {
            anchorConstraint.width = widthAnchor.constraint(equalToConstant: size.width)
        }
        
        if size.height != 0 {
            anchorConstraint.height = heightAnchor.constraint(equalToConstant: size.height)
        }
        
        [anchorConstraint.top, anchorConstraint.bottom, anchorConstraint.leading, anchorConstraint.trailing, anchorConstraint.width, anchorConstraint.height].forEach { $0?.isActive = true }
        
        return anchorConstraint
    }
    
    func positionInCenterSuperView(size: CGSize = .zero, centerX: NSLayoutXAxisAnchor?, centerY: NSLayoutYAxisAnchor?) {
        
        translatesAutoresizingMaskIntoConstraints = false
        
        if let centerX = centerX {
            centerXAnchor.constraint(equalTo: centerX).isActive = true
        }
        
        if let centerY = centerY {
            centerYAnchor.constraint(equalTo: centerY).isActive = true
        }
        
        if size.width != 0 {
            widthAnchor.constraint(equalToConstant: size.width).isActive = true
        }
        
        if size.height != 0 {
            heightAnchor.constraint(equalToConstant: size.height).isActive = true
        }
    }
}

extension UIColor {
    
    static func rgb(_ red: CGFloat, _ green: CGFloat, _ blue: CGFloat) -> UIColor {
        return UIColor.init(red: red/255, green: green/255, blue: blue/255, alpha: 1)
    }
}
