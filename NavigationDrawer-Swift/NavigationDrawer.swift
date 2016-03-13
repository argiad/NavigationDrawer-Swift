//
//  NavigationDrawer.swift
//  NavigationDrawer-Swift
//
//  Created by Nishan on 2/25/16.
//  Copyright © 2016 Nishan. All rights reserved.
//

import Foundation
import UIKit

@objc protocol NavigationDrawerDelegate
{
    optional func navigationDrawerDidShow(didShow:Bool)
    optional func navigationDrawerDidHide(didHide:Bool)
}

class NavigationDrawer: NSObject
{
    
    static let sharedInstance = NavigationDrawer()
    
    //MARK: Public variable
    var delegate:NavigationDrawerDelegate?
    
    //MARK: Private Variables
    private var options:NavigationDrawerOptions!
    private var isDrawerShown = false
    private var navigationDrawerContainer = UIView()
    private var navigationDrawer = UIView()
    
    /*
    Sets options for Navigation Drawer and starts preparing navigation drawer for display
    
    - params: options: NavigationDrawerOptions
    */
    func setup(withOptions options:NavigationDrawerOptions)
    {
        self.options = options
        //initNavigationDrawer() -> Doing this over there
    }
    
    /*
    Initializes View Controller and Navigation Drawer with the options provided.
    */
    private func initNavigationDrawer()
    {
        //setting up container for navigation drawer
        navigationDrawerContainer.frame = CGRectMake(0, 0, options.getAnchorViewWidth(), options.getAnchorViewHeight())
        navigationDrawerContainer.backgroundColor = UIColor.blackColor().colorWithAlphaComponent(0)
        
        //Tap gesture to hide drawer
        let tapGesture = UITapGestureRecognizer(target: self, action: "handleTapNavigation:")
        tapGesture.numberOfTapsRequired = 1
        tapGesture.numberOfTouchesRequired = 1
        tapGesture.delegate = self
        navigationDrawerContainer.addGestureRecognizer(tapGesture)
        
        //swipe gesture to hide and show drawer
        let drawerCloseGesture = UISwipeGestureRecognizer(target: self, action: "handleSwipeNavigation:")
        
        if options.navigationDrawerType == NavigationDrawerType.LeftDrawer
        {
            let leftToRightSwiper = UISwipeGestureRecognizer(target: self, action: "handleSwipeNavigation:")
            leftToRightSwiper.direction = .Right
            drawerCloseGesture.direction = .Left
            options.anchorView!.addGestureRecognizer(leftToRightSwiper)
        }
        else
        {
            let rightToLeftSwiper = UISwipeGestureRecognizer(target: self, action: "handleSwipeNavigation:")
            rightToLeftSwiper.direction = .Left
            drawerCloseGesture.direction = .Right
            options.anchorView!.addGestureRecognizer(rightToLeftSwiper)
        }
        
        //setting up navigation drawer
        navigationDrawer.frame = CGRectMake(options.getNavigationDrawerXPosition(), options.navigationDrawerYPosition, options.navigationDrawerWidth, options.navigationDrawerHeight)
        navigationDrawer.backgroundColor = options!.navigationDrawerBackgroundColor
        navigationDrawer.addGestureRecognizer(drawerCloseGesture)
        navigationDrawerContainer.addSubview(navigationDrawer)
        
    }
    
    
    /*
    Hides or Shows Navigation drawer with animation
    
    - params: completionHandler closure for handling completion of toggling of navigation drawer
    */
    func toggleNavigationDrawer(completionHandler: (()->Void)?)
    {
        if !isDrawerShown
        {
            isDrawerShown = true
            self.options.anchorView!.addSubview(self.navigationDrawerContainer)
            self.options.anchorView!.bringSubviewToFront(self.navigationDrawerContainer)
            
            if options.navigationDrawerType == NavigationDrawerType.LeftDrawer
            {
                navigationDrawer.frame.origin.x = -options.navigationDrawerWidth
                
                UIView.animateWithDuration(0.5, animations: {[unowned self]() -> Void in
                    
                    self.navigationDrawer.frame.origin.x += self.options.navigationDrawerWidth
                    self.navigationDrawerContainer.backgroundColor = UIColor.blackColor().colorWithAlphaComponent(0.4)
                    }, completion: {[unowned self](finished) -> Void in
                        if finished
                        {
                            self.delegate?.navigationDrawerDidShow?(true)
                            completionHandler?()
                        }
                })
            }
            else
            {
                navigationDrawer.frame.origin.x += options.navigationDrawerWidth
                UIView.animateWithDuration(0.5, animations: { () -> Void in
                    
                    self.navigationDrawer.frame.origin.x -= self.options.navigationDrawerWidth
                    //self.navigationDrawerContainer.alpha = 0.4
                    self.navigationDrawerContainer.backgroundColor = UIColor.blackColor().colorWithAlphaComponent(0.4)
                    }, completion: { (finished) -> Void in
                        self.delegate?.navigationDrawerDidShow?(true)
                        completionHandler?()
                })
            }
        }
        else
        {
            isDrawerShown = false
            if options.navigationDrawerType == NavigationDrawerType.LeftDrawer
            {
                UIView.animateWithDuration(0.5, animations: {[unowned self]() -> Void in
                    
                    self.navigationDrawer.frame.origin.x -= self.options.navigationDrawerWidth
                   self.navigationDrawerContainer.backgroundColor = UIColor.blackColor().colorWithAlphaComponent(0)
                    }, completion: {[unowned self](finished) -> Void in
                        if finished
                        {
                            self.navigationDrawerContainer.removeFromSuperview()
                            self.delegate?.navigationDrawerDidHide?(true)
                            completionHandler?()
                        }
                })
            }
            else
            {
                UIView.animateWithDuration(0.5, animations: {[unowned self]() -> Void in
                    
                    self.navigationDrawer.frame.origin.x += self.options.navigationDrawerWidth
                    self.navigationDrawerContainer.backgroundColor = UIColor.blackColor().colorWithAlphaComponent(0)
                    }, completion: {[unowned self](finished) -> Void in
                        if finished
                        {
                            self.navigationDrawerContainer.removeFromSuperview()
                            self.navigationDrawer.frame.origin.x = self.options.navigationDrawerXPosition
                            self.delegate?.navigationDrawerDidHide?(true)
                            completionHandler?()
                        }
                    })
            }
        }
    }
    
    /*
    Handles Tap to hide navigation drawer
    
    -params: UITapGestureRecognizer
    */
    func handleTapNavigation(sender:UITapGestureRecognizer)
    {
        toggleNavigationDrawer(nil)
    }
    
    /*
    Handles Left and Right navigation swipe to show navigation drawer
    
    -params: UISwipeGestureRecognizer
    */
    func handleSwipeNavigation(sender:UISwipeGestureRecognizer)
    {
        let location = sender.locationInView(options.anchorView).x
        
        if !isDrawerShown
        {
           //For Opening
            if options.navigationDrawerOpenDirection == NavigationDrawerOpenDirection.AnyWhere
            {
                toggleNavigationDrawer(nil)
            }
            else
            {
                if sender.direction == UISwipeGestureRecognizerDirection.Right
                {
                    if location <= options.navigationDrawerEdgeSwipeDistance
                    {
                        toggleNavigationDrawer(nil)
                    }
                }
                else if sender.direction == UISwipeGestureRecognizerDirection.Left
                {
                    if location >= options.getAnchorViewWidth() - options.navigationDrawerEdgeSwipeDistance
                    {
                        toggleNavigationDrawer(nil)
                    }
                }
            }
        
        }
        else
        {
            //For Closing
            if options.navigationDrawerType == NavigationDrawerType.LeftDrawer{
                if sender.direction == UISwipeGestureRecognizerDirection.Left
                {
                    toggleNavigationDrawer(nil)
                }
            }
            else
            {
                if sender.direction == UISwipeGestureRecognizerDirection.Right
                {
                    toggleNavigationDrawer(nil)
                }
            }
            
        }
    }
    
    
    /*
    Sets the view controller for navigation drawer
    
    - params: UIViewController which controls Navigation Drawer
    */
    func setNavigationDrawerController(viewController:UIViewController)
    {
        self.options.drawerController = viewController
        viewController.view.frame = navigationDrawer.bounds
        self.navigationDrawer.addSubview(viewController.view)
    }
    
    
    /*
    Reinitializes the navigation drawer view for the current ViewController. Any View Controller calling this methods will have navigation drawer available for it with the same configuration which was supplied during its first initialization.
    
    -params: UIViewController in which navigation drawer is to be shown
    */
    func initialize(forViewController viewController:UIViewController)
    {
        options.anchorView = viewController.view
        options.initDefaults()
        viewController.addChildViewController(options.drawerController!)
        initNavigationDrawer()
    }
    
}



extension NavigationDrawer: UIGestureRecognizerDelegate{
    
    /*
    Disables touch gesture for navigation drawer
    */
    func gestureRecognizer(gestureRecognizer: UIGestureRecognizer, shouldReceiveTouch touch: UITouch) -> Bool
    {
        
        let location = touch.locationInView(options.anchorView)
        
        if CGRectContainsPoint(navigationDrawer.frame, location)
        {
            return false
        }
        return true
    }
}