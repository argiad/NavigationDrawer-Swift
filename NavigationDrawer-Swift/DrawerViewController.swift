//
//  DrawerViewController.swift
//  NavigationDrawer-Swift
//
//  Created by Nishan on 2/25/16.
//  Copyright © 2016 Nishan. All rights reserved.
//

import UIKit

class DrawerViewController: UIViewController,UITableViewDataSource,UITableViewDelegate {

    @IBOutlet weak var tableView: UITableView!
    
    let menuItem = ["Home","Favourites","Recommended","Feedback","Settings"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.dataSource = self
        tableView.delegate = self
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return menuItem.count
    }
  
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell
    {
        let cell = tableView.dequeueReusableCellWithIdentifier("Cell")
        
        cell?.textLabel?.text = menuItem[indexPath.row]
        
        return cell!
    }
   
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath)
    {
        NavigationDrawer.sharedInstance.toggleNavigationDrawer { () -> Void in
            
            if indexPath.row != 0
            {
            
            let vc = self.storyboard?.instantiateViewControllerWithIdentifier("TestViewController") as! TestViewController
            vc.text = self.menuItem[indexPath.row]
            self.navigationController?.viewControllers = [vc]
            
            }
            else
            {
                let vc = self.storyboard?.instantiateViewControllerWithIdentifier("HomeViewController")
                self.navigationController?.viewControllers = [vc!]

            }
        }
    }
        
}

