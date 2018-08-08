//
//  TestViewController.swift
//  NavigationDrawer-Swift
//
//  Created by Nishan on 2/28/16.
//  Copyright © 2016 Nishan. All rights reserved.
//
//  Edited by Artem Mkrtchyan 8/7/2018
//

import UIKit

class TestViewController: UIViewController {
    
    @IBOutlet weak var testLabel: UILabel!
    
    var text:String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        testLabel.text = text
        
        self.navigationItem.leftBarButtonItem = UIBarButtonItem( image: UIImage(named: "drawer_icon"), style: .plain, target: self, action: #selector(TestViewController.showDrawer))
        
        NavigationDrawer.instance.initialize(forViewController: self)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    @objc func showDrawer()
    {
        NavigationDrawer.instance.toggleNavigationDrawer(completionHandler: nil)
    }

  
}
