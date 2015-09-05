//
//  VisualExtensions.swift
//  Lookie!
//
//  Created by PATRICK PERINI on 8/20/15.
//  Copyright (c) 2015 AppCookbook. All rights reserved.
//

import UIKit

@IBDesignable extension UIView {
    // MARK: Properties
    
    // Borders
    @IBInspectable var borderWidth: CGFloat {
        get { return self.layer.borderWidth }
        set { self.layer.borderWidth = newValue }
    }
    
    @IBInspectable var borderColor: UIColor? {
        get { return UIColor(CGColor: self.layer.borderColor!) }
        set { self.layer.borderColor = newValue?.CGColor }
    }
    
    // Corners & Bounds
    @IBInspectable var cornerRadius: CGFloat {
        get { return self.layer.cornerRadius }
        set { self.layer.cornerRadius = newValue }
    }
    
    @IBInspectable var masksToBounds: Bool {
        get { return self.layer.masksToBounds }
        set { self.layer.masksToBounds = newValue }
    }
    
    // Shadows
    @IBInspectable var shadowRadius: CGFloat {
        get { return self.layer.shadowRadius }
        set { self.layer.shadowRadius = newValue }
    }
    
    @IBInspectable var shadowOffset: CGSize {
        get { return self.layer.shadowOffset }
        set { self.layer.shadowOffset = newValue }
    }
    
    @IBInspectable var shadowColor: UIColor? {
        get { return UIColor(CGColor: self.layer.shadowColor!) }
        set { self.layer.shadowColor = newValue?.CGColor }
    }
    
    @IBInspectable var shadowAlpha: CGFloat {
        get { return CGFloat(self.layer.shadowOpacity) }
        set { self.layer.shadowOpacity = Float(newValue) }
    }
}

@IBDesignable class TextField: UITextField {
    // MARK: Properties
    @IBInspectable var textInsets: CGSize = CGSize()
    
    override func textRectForBounds(bounds: CGRect) -> CGRect {
        return CGRectInset(bounds, self.textInsets.width, self.textInsets.height)
    }
    
    override func editingRectForBounds(bounds: CGRect) -> CGRect {
        return CGRectInset(bounds, self.textInsets.width, self.textInsets.height)
    }
}

class Button: UIButton {
    var associatedObject: AnyObject?
}