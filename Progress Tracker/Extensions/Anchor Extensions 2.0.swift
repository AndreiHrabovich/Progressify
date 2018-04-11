//
//  Anchor Extensions 2.0.swift
//  CodeAutoLayoutNew
//
//  Created by Andrei on 2/18/18.
//  Copyright © 2018 Andrei. All rights reserved.
//

import UIKit

extension UIView {
    // filling the superview
    func fillSuperView() {
        translatesAutoresizingMaskIntoConstraints = false
        anchor(centerX: nil, centerY: nil, top: superview?.topAnchor, leading: superview?.leadingAnchor, bottom: superview?.bottomAnchor, trailing: superview?.trailingAnchor)
    }
    
    // settting relative dynamic sizes as percent of another view
    func anchorSizeRelative(to view: UIView, widthMultipler: CGFloat = 1, heightMultipler: CGFloat = 1) {
        translatesAutoresizingMaskIntoConstraints = false
        widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: widthMultipler).isActive = true
        heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: heightMultipler).isActive = true
    }
    
    // can be used to hardcode the size for quick prototyping
    func anchorStaticSize(size: CGSize) {
        translatesAutoresizingMaskIntoConstraints = false
        widthAnchor.constraint(equalToConstant: size.width).isActive = true
        heightAnchor.constraint(equalToConstant: size.height).isActive = true
    }
    
    // quickly centering the view for quick prototyping
    func anchorCenterPosition(to view: UIView, shiftPoint: CGPoint = .zero) {
        translatesAutoresizingMaskIntoConstraints = false
        centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: shiftPoint.x).isActive = true
        centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: shiftPoint.y).isActive = true
    }
    
    // the key anchoring method
    func anchor(centerX: NSLayoutXAxisAnchor?, centerY: NSLayoutYAxisAnchor?, top: NSLayoutYAxisAnchor?, leading: NSLayoutXAxisAnchor?, bottom: NSLayoutYAxisAnchor?,trailing: NSLayoutXAxisAnchor?, padding: UIEdgeInsets = .zero, size: CGSize = .zero) {
        
        translatesAutoresizingMaskIntoConstraints = false
        
        if let centerX = centerX {
            centerXAnchor.constraint(equalTo: centerX).isActive = true
        }
        
        if let centerY = centerY {
            centerYAnchor.constraint(equalTo: centerY).isActive = true
        }
        
        if let top = top {
            topAnchor.constraint(equalTo: top, constant: padding.top).isActive = true
        }
        
        if let leading = leading {
            leadingAnchor.constraint(equalTo: leading, constant: padding.left).isActive = true
        }
        
        if let bottom = bottom {
            bottomAnchor.constraint(equalTo: bottom, constant: -padding.bottom).isActive = true
        }
        
        if let trailing = trailing {
            trailingAnchor.constraint(equalTo: trailing, constant: -padding.right).isActive = true
        }
        
        // use these parameters to hardcode the size (for dynamic sizing, use the anchorSize method)
        
        if size.width != 0 {
            widthAnchor.constraint(equalToConstant: size.width).isActive = true
        }
        if size.height != 0 {
            heightAnchor.constraint(equalToConstant: size.height).isActive = true
        }
    }
}





