//
//  ContactTableViewController.swift
//  CancerSN
//
//  Created by lily on 9/17/15.
//  Copyright (c) 2015 lily. All rights reserved.
//

import UIKit

class ContactTableViewController: UITableViewController {
    
//    var username = String()
    var haalthyService = HaalthyService()
    var contactList = NSArray()

    @IBAction func cancel(sender: UIButton) {
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        var userListData = NSData()
        let keychainAccess = KeychainAccess()
        let username = keychainAccess.getPasscode(usernameKeyChain) as! String

        userListData = haalthyService.getFollowingUsers(username)!

        let jsonResult = try? NSJSONSerialization.JSONObjectWithData(userListData, options: NSJSONReadingOptions.MutableContainers)
        if jsonResult is NSArray {
            contactList = jsonResult as! NSArray
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Potentially incomplete method implementation.
        // Return the number of sections.
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete method implementation.
        // Return the number of rows in the section.
        return contactList.count
    }

    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("contactListCell", forIndexPath: indexPath) 
        var user = contactList[indexPath.row] as! NSDictionary
        // Configure the cell...
        if((user["image"] is NSNull) == false){
            let dataString = user.objectForKey("image") as! String
            let imageData: NSData = NSData(base64EncodedString: dataString, options: NSDataBase64DecodingOptions(rawValue: 0))!
            
            cell.imageView?.image = UIImage(data: imageData)
        }
        cell.textLabel?.text = user.objectForKey("username") as! String

        return cell
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
    }
    /*
    // Override to support conditional editing of the table view.
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return NO if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            // Delete the row from the data source
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        } else if editingStyle == .Insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(tableView: UITableView, moveRowAtIndexPath fromIndexPath: NSIndexPath, toIndexPath: NSIndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(tableView: UITableView, canMoveRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return NO if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using [segue destinationViewController].
        // Pass the selected object to the new view controller.
    }
    */

}
