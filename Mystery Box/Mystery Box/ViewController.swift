//
//  ViewController.swift
//  Mystery Box
//
//  Created by PATRICK PERINI on 8/24/15.
//  Copyright (c) 2015 AppCookbook. All rights reserved.
//

import UIKit
import Parse
import AFNetworking
import ACBInfoPanel

class ViewController: UIViewController {
    // MARK: Properties
    @IBOutlet var boxView: UIView!
    @IBOutlet var boxVerticalConstraint: NSLayoutConstraint!
    @IBOutlet var boxViewWidthConstraint: NSLayoutConstraint!
    @IBOutlet var boxViewHeightConstraint: NSLayoutConstraint!
    var boxHasReachedMaxSize: Bool = false
    
    @IBOutlet var backgroundView: UIImageView!
    @IBOutlet var titleContainerView: UIView!
    @IBOutlet var imageView: UIImageView!
    @IBOutlet var descriptionContainerView: UIView!
    @IBOutlet var buttons: [UIButton] = []
    
    @IBOutlet var dateLabel: UILabel!
    @IBOutlet var titleLabel: UILabel!
    @IBOutlet var descriptionLabel: UILabel!
    
    var latestContent: Content? {
        didSet {
            self.titleLabel.text = self.latestContent!.title
            self.imageView.setImageWithURL(self.latestContent!.thumbnailURL)
            self.descriptionLabel.text = self.latestContent!.descriptionText
            
            let formatter = NSDateFormatter()
            formatter.dateFormat = "MMMM dd, YYYY"
            self.dateLabel.text = formatter.stringFromDate(self.latestContent!.createdAt!)
        }
    }
    
    override func preferredStatusBarStyle() -> UIStatusBarStyle {
        return self.boxHasReachedMaxSize ? .LightContent : .Default
    }
    
    // MARK: Lifecycle
    override func viewDidLoad() {
        var query = Content.query()
        query?.orderByDescending("createdAt")
        query?.getFirstObjectInBackgroundWithBlock { (obj: PFObject?, err: NSError?) in
            self.latestContent = obj as? Content
            self.bringInBox()
        }
    }
    
    override func viewDidAppear(animated: Bool) {
        if !self.boxHasReachedMaxSize {
            self.titleContainerView.transform = CGAffineTransformMakeScale(0, 0)
            self.imageView.transform = CGAffineTransformMakeScale(0, 0)
            self.descriptionContainerView.transform = CGAffineTransformMakeScale(0, 0)
            for button in self.buttons { button.transform = CGAffineTransformMakeScale(0, 0) }
        }
    }
    
    // MARK: Animation Handlers
    func bringInBox() {
        UIView.animateWithDuration(0.33, delay: 0.00, usingSpringWithDamping: 0.5, initialSpringVelocity: 1.5, options: UIViewAnimationOptions.CurveEaseInOut, animations: { () -> Void in
            self.boxVerticalConstraint.constant = 0
            self.boxView.layoutIfNeeded()
        }, completion: { (_: Bool) in
            self.popBox()
        })
    }
    
    func popBox() {
        let view = self.boxView
        var accumulatedDelay: NSTimeInterval = 1.5

        dispatch_after(accumulatedDelay) {
            view.shake(120, intensity: CGSizeMake(20, 0))
            view.rotate(120, intensity: M_PI / 10.0)
            view.resize(1.0,
                widthConstraint: self.boxViewWidthConstraint,
                heightConstraint: self.boxViewHeightConstraint,
                size: view.frame.size.scaled(1.3))
        }
        
        accumulatedDelay += 2.0
        dispatch_after(accumulatedDelay) {
            view.shake(150, intensity: CGSizeMake(20, 0))
            view.rotate(150, intensity: M_PI / 10.0)
            view.resize(1.0,
                widthConstraint: self.boxViewWidthConstraint,
                heightConstraint: self.boxViewHeightConstraint,
                size: view.frame.size.scaled(1.5))
        }

        accumulatedDelay += 2.0
        dispatch_after(accumulatedDelay) {
            view.shake(180, intensity: CGSizeMake(20, 0))
            view.rotate(180, intensity: M_PI / 10.0)
            view.resize(1.0,
                widthConstraint: self.boxViewWidthConstraint,
                heightConstraint: self.boxViewHeightConstraint,
                size: view.frame.size.scaled(1.8))
        }

        accumulatedDelay += 1.0
        dispatch_after(accumulatedDelay) {
            self.boxHasReachedMaxSize = true
            self.setNeedsStatusBarAppearanceUpdate()
            
            self.backgroundView.hidden = false
            self.titleContainerView.hidden = false
            self.imageView.hidden = false
            self.descriptionContainerView.hidden = false
            for button in self.buttons { button.hidden = false }

            view.explode()
        }
        
        accumulatedDelay += 1.0
        dispatch_after(accumulatedDelay) {
            self.boxView.hidden = true
            self.popInContent()
        }
    }
    
    func popInContent() {
        UIView.animateWithDuration(0.3, delay: 0.0, usingSpringWithDamping: 0.9, initialSpringVelocity: 0.2, options: UIViewAnimationOptions.CurveLinear, animations: {
            self.titleContainerView.transform = CGAffineTransformIdentity
        }, completion: nil)
        
        UIView.animateWithDuration(0.3, delay: 0.2, usingSpringWithDamping: 0.9, initialSpringVelocity: 0.2, options: UIViewAnimationOptions.CurveLinear, animations: {
            self.imageView.transform = CGAffineTransformIdentity
        }, completion: nil)
        
        UIView.animateWithDuration(0.3, delay: 0.1, usingSpringWithDamping: 0.9, initialSpringVelocity: 0.2, options: UIViewAnimationOptions.CurveLinear, animations: {
            self.descriptionContainerView.transform = CGAffineTransformIdentity
        }, completion: nil)
        
        UIView.animateWithDuration(0.2, delay: 0.3, usingSpringWithDamping: 0.9, initialSpringVelocity: 0.2, options: UIViewAnimationOptions.CurveLinear, animations: {
            for button in self.buttons { button.transform = CGAffineTransformIdentity }
        }, completion: nil)
    }
    
    // MARK: Responders
    @IBAction func shareButtonWasPressed(sender: UIButton!) {
        let activityVC = UIActivityViewController(activityItems: [
            self.latestContent!.url
        ], applicationActivities: nil)
        self.presentViewController(activityVC,
            animated: true,
            completion: nil)
    }
    
    @IBAction func aboutButtonWasPressed(sender: UIButton!) {
        let aboutVC = ACBInfoPanelViewController()
        aboutVC.ingredient = "Mystery Box"
        self.presentViewController(aboutVC,
            animated: true,
            completion: nil)
    }
}

