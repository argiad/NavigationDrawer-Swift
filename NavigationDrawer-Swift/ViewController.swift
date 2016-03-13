//
//  ViewController.swift
//  NavigationDrawer-Swift
//
//  Created by Nishan on 2/25/16.
//  Copyright © 2016 Nishan. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    var navigationDrawer:NavigationDrawer!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "Awesome Navigation Drawer"
    
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(title: "<", style: UIBarButtonItemStyle.Plain, target: self, action: "showDrawer")
        
        let options = NavigationDrawerOptions()
        options.navigationDrawerType = .LeftDrawer
        options.navigationDrawerOpenDirection = .AnyWhere
        options.navigationDrawerYPosition = 64
        
        let vc = self.storyboard?.instantiateViewControllerWithIdentifier("DrawerViewController") as! DrawerViewController
        navigationDrawer = NavigationDrawer.sharedInstance
        navigationDrawer.setup(withOptions: options)
        navigationDrawer.setNavigationDrawerController(vc)
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(true)
        
        NavigationDrawer.sharedInstance.initialize(forViewController: self)
        
    }
    
    func showDrawer()
    {
        NavigationDrawer.sharedInstance.toggleNavigationDrawer(nil)
    }

    
      
}

