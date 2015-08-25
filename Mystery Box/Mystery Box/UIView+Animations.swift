//
//  UIView+Animations.swift
//  Mystery Box
//
//  Created by PATRICK PERINI on 8/24/15.
//  Copyright (c) 2015 AppCookbook. All rights reserved.
//

import Foundation

extension UIView {
    func shake(repeatCount: Float, intensity: CGSize) {
        let animation = CABasicAnimation(keyPath: "position")
        animation.speed = 100.0
        
        animation.repeatCount = repeatCount
        animation.autoreverses = true
        
        animation.fromValue = NSValue(CGPoint: CGPoint(x: self.center.x - (intensity.width / 2.0),
            y: self.center.y - (intensity.height / 2.0)))
        animation.toValue = NSValue(CGPoint: CGPoint(x: self.center.x + (intensity.width / 2.0),
            y: self.center.y + (intensity.height / 2.0)))
        
        self.layer.addAnimation(animation, forKey: "shake")
    }
    
    func rotate(repeatCount: Float, intensity: Double) {
        let animation = CABasicAnimation(keyPath: "transform.rotation.z")
        animation.speed = 100.0
        
        animation.repeatCount = repeatCount
        animation.autoreverses = true
        
        animation.fromValue = NSNumber(double: (intensity / -2.0))
        animation.toValue = NSNumber(double: (intensity / 2.0))
        
        self.layer.addAnimation(animation, forKey: "rotate")
    }
    
    func scale(duration: NSTimeInterval, scale: CGFloat, completion: () -> Void = {}) {
        UIView.animateWithDuration(duration, animations: {
            self.transform = CGAffineTransformScale(self.transform, scale, scale)
        }, completion: { (_: Bool) in
            completion()
        })
    }
    
    func resize(duration: NSTimeInterval, widthConstraint: NSLayoutConstraint, heightConstraint: NSLayoutConstraint, size: CGSize, completion: () -> Void = {}) {
        widthConstraint.constant = size.width
        heightConstraint.constant = size.height
        
        UIView.animateWithDuration(duration, animations: {
            self.layoutIfNeeded()
        }, completion: { (_: Bool) in
            completion()
        })
    }
}

extension CGSize {
    func scaled(factor: CGFloat) -> CGSize {
        return CGSizeApplyAffineTransform(self, CGAffineTransformMakeScale(factor, factor))
    }
}