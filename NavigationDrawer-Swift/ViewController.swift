//
//  ViewController.swift
//  NavigationDrawer-Swift
//
//  Created by Nishan on 2/25/16.
//  Copyright © 2016 Nishan. All rights reserved.
//
//  Edited by Artem Mkrtchyan 8/7/2018
//

import UIKit

class ViewController: UIViewController {

    var navigationDrawer:NavigationDrawer!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "Awesome Navigation Drawer"
    
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(title: "<", style: UIBarButtonItemStyle.plain, target: self, action: #selector(ViewController.showDrawer))
        
        let options = NavigationDrawerOptions()
        options.navigationDrawerType = .leftDrawer
        options.navigationDrawerOpenDirection = .anyWhere
        options.navigationDrawerYPosition = 0
        options.navigationDrawerAnchorController = .window
        
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "DrawerViewController") as! DrawerViewController
        navigationDrawer = NavigationDrawer.instance
        navigationDrawer.setup(withOptions: options)
        navigationDrawer.setNavigationDrawerController(viewController: vc)
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        
        NavigationDrawer.instance.initialize(forViewController: self)
        
    }
    
    @objc func showDrawer()
    {
        NavigationDrawer.instance.toggleNavigationDrawer(completionHandler: nil)
    }

    
      
}

