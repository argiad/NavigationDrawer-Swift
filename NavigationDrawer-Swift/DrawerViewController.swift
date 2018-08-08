//
//  DrawerViewController.swift
//  NavigationDrawer-Swift
//
//  Created by Nishan on 2/25/16.
//  Copyright © 2016 Nishan. All rights reserved.
//
//  Edited by Artem Mkrtchyan 8/7/2018
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
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return menuItem.count
    }
  
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell")
        
        cell?.textLabel?.text = menuItem[indexPath.row]
        
        return cell!
    }
   
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)
    {
        let drawer = NavigationDrawer.instance
        drawer.toggleNavigationDrawer { () -> Void in
            if let controller = (( drawer.options.navigationDrawerAnchorController == .parent) ? self.parent?.navigationController : UIApplication.shared.delegate?.window??.rootViewController) as? UINavigationController {
                if indexPath.row != 0
                {
                    
                    let vc = self.storyboard?.instantiateViewController(withIdentifier: "TestViewController") as! TestViewController
                    vc.text = self.menuItem[indexPath.row]
                    controller.viewControllers = [vc]
                    
                }
                else
                {
                    let vc = self.storyboard?.instantiateViewController(withIdentifier: "HomeViewController")
                    controller.viewControllers = [vc!]
                    
                }
            }
        }
    }
        
}

