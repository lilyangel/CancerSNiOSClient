//
//  AddItemViewController.swift
//  CancerSN
//
//  Created by lily on 8/4/15.
//  Copyright (c) 2015 lily. All rights reserved.
//

import UIKit

class AddItemViewController: UIViewController {

    var isBroadcast : Int = 0
    let profileSet = NSUserDefaults.standardUserDefaults()

    @IBAction func addBroadcast(sender: UIButton) {
        if profileSet.objectForKey(accessNSUserData) == nil{
            self.performSegueWithIdentifier("loginSegue", sender: nil)
        }
        self.isBroadcast = 1
        self.performSegueWithIdentifier("addPostSegue", sender: nil)
    }
    
    @IBAction func addPrivatePost(sender: UIButton) {
        if profileSet.objectForKey(accessNSUserData) == nil{
            self.performSegueWithIdentifier("loginSegue", sender: nil)
        }
        self.isBroadcast = 0
        self.performSegueWithIdentifier("addPostSegue", sender: nil)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    @IBAction func cancel(sender: UIButton) {
//        self.dismissViewControllerAnimated(false, completion: nil)
        self.tabBarController?.selectedIndex = 1
    }
    
    override func viewWillAppear(animated: Bool) {
        self.navigationController?.navigationBar.hidden = true
        self.tabBarController?.tabBar.hidden = true
        self.navigationController?.navigationBar.hidden = true
        let getAccessToken: GetAccessToken = GetAccessToken()
        getAccessToken.getAccessToken()

    }
    
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "addPostSegue" {
            (segue.destinationViewController as! AddPostViewController).isBroadcast = self.isBroadcast
        }
    }
    
    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)
        self.tabBarController?.tabBar.hidden = false
        self.navigationController?.navigationBar.hidden = false
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
