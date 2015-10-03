//
//  TagViewController.swift
//  CancerSN
//
//  Created by lily on 7/20/15.
//  Copyright (c) 2015 lily. All rights reserved.
//

import UIKit

protocol TagVCDelegate {
    func updateTagList(data: NSArray)
}

//protocol PostTagVCDelegate{
//    func getPostTagList(data: NSArray)
//}

class TagViewController: UITableViewController {
    var delegate: TagVCDelegate?
//    var postDelegate: PostTagVCDelegate?
    var tags: NSArray = []
    var selectedTags : NSMutableArray = []
    
    var isBroadcastTagSelection = 0
    var postBody:String = String()
    var keychain = KeychainAccess()
    var haalthyService = HaalthyService()

    
    @IBAction func cancel(sender: UIButton) {
        self.dismissViewControllerAnimated(false, completion: nil)
    }
    @IBOutlet var tagList: UITableView!
    
    let tagLabelColor: UIColor = UIColor.init(red:0.8, green:0.8, blue:1, alpha:0.65)
    
    let tagSelectedLabelColor : UIColor = UIColor.init(red:0.7, green:0.7, blue:1, alpha:1)

    let submitSelectedColor : UIColor = UIColor.init(red:0.9, green:0.7, blue:1, alpha:1)
    
    func sendSyncGetTagListRequet()->NSData{
        let urlPath: String = getTagListURL
        var url: NSURL = NSURL(string: urlPath)!
        var request: NSURLRequest = NSURLRequest(URL: url)
        var response: AutoreleasingUnsafeMutablePointer<NSURLResponse?> = nil
        return NSURLConnection.sendSynchronousRequest(request, returningResponse: response, error: nil)!
    }
    
    func sendUpdateTagsHttpRequest()->NSData{
        let getAccessToken: GetAccessToken = GetAccessToken()
        getAccessToken.getAccessToken()
        let accessToken = NSUserDefaults.standardUserDefaults().objectForKey(accessNSUserData)
        var url: NSURL = NSURL(string: updateFavTagsURL + "?access_token=" + (accessToken as! String))!
        var request: NSMutableURLRequest = NSMutableURLRequest(URL: url)
        request.HTTPMethod = "POST"
        var tagListDic = NSMutableDictionary()
        tagListDic.setValue(selectedTags, forKey: "tags")
        request.HTTPBody = NSJSONSerialization.dataWithJSONObject(tagListDic, options: NSJSONWritingOptions.allZeros, error: nil)
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        println(NSString(data: (request.HTTPBody)!, encoding: NSUTF8StringEncoding)!)
        println(request.HTTPBody)
        var response: AutoreleasingUnsafeMutablePointer<NSURLResponse?> = nil
        return NSURLConnection.sendSynchronousRequest(request, returningResponse: response, error: nil)!
    }
    
    
    @IBAction func tagsSubmit(sender: AnyObject) {
        if self.isBroadcastTagSelection == 0{
            let favtags = NSUserDefaults.standardUserDefaults()
            favtags.setObject(self.selectedTags, forKey: favTagsNSUserData)
            self.delegate?.updateTagList(self.selectedTags)
            if(keychain.getPasscode(usernameKeyChain) != nil && keychain.getPasscode(passwordKeyChain) != nil){
                var updateUserTagsRespData = self.sendUpdateTagsHttpRequest()
            }
        }else{
//            self.postDelegate?.getPostTagList(self.selectedTags)
        }
        self.dismissViewControllerAnimated(false, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.hidden = true
        tagList.separatorColor = UIColor.clearColor()
        
        var getTagListRespData:NSData = self.sendSyncGetTagListRequet()
        var jsonResult = NSJSONSerialization.JSONObjectWithData(getTagListRespData, options: NSJSONReadingOptions.MutableContainers, error: nil)
        if(jsonResult is NSArray){
            self.tags = jsonResult as! NSArray
        }
        self.extendedLayoutIncludesOpaqueBars = true
        if (selectedTags.count == 0) && (keychain.getPasscode(usernameKeyChain) != nil) && (isBroadcastTagSelection == 0){
            var getUserFavTagsData = haalthyService.getUserFavTags()
            var jsonResult = NSJSONSerialization.JSONObjectWithData(getUserFavTagsData!, options: NSJSONReadingOptions.MutableContainers, error: nil)
            self.selectedTags = jsonResult as! NSMutableArray
        }
//        self.tableView.allowsSelection = false
    }

    override func viewWillDisappear(animated: Bool) {
        self.tabBarController?.tabBar.hidden = false
    }
    override func preferredStatusBarStyle() -> UIStatusBarStyle {
        return .LightContent
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Potentially incomplete method implementation.
        // Return the number of sections.
        return 3
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if(section == 0){
            return 1
        }
        if(section == 1){
            return tags.count
        }
        if(section == 2){
            return 1
        }
        return 0
    }

    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {

        if(indexPath.section == 0){
            let cell = tableView.dequeueReusableCellWithIdentifier("header", forIndexPath: indexPath) as! TagHeaderTableViewCell
            if isBroadcastTagSelection == 1{
                cell.header.text = "请选择发布问题的标签"
                cell.cancelBtn.hidden = true
            }else{
                cell.cancelBtn.hidden = false
                cell.header.text = "请选择您关注的标签"
            }
            cell.header.textColor = textColor
            return cell
        }
            // Configure the cell...
        else if(indexPath.section == 1){
            let cell = tableView.dequeueReusableCellWithIdentifier("list", forIndexPath: indexPath) as! TagListTableViewCell
            var tag: NSDictionary = tags[indexPath.row] as! NSDictionary
            cell.tagList.text = tag["name"] as? String
            cell.tagList.layer.borderColor = textColor.CGColor
            cell.tagList.layer.borderWidth = 2.0
            cell.tagList.layer.cornerRadius = 5
            cell.tagList.layer.masksToBounds = true
            if(selectedTags.containsObject(tags[indexPath.row])){
                cell.tagList.backgroundColor = textColor
                cell.tagList.textColor = UIColor.whiteColor()
            }else{
                cell.tagList.backgroundColor = UIColor.whiteColor()
                cell.tagList.textColor = textColor
            }
            return cell
        }
        else{
            let cell = tableView.dequeueReusableCellWithIdentifier("footer", forIndexPath: indexPath) as! TagFooterTableViewCell
            cell.tagsSelect.titleLabel?.text = "确认"
            cell.tagsSelect.layer.cornerRadius = 5
            cell.tagsSelect.clipsToBounds = true
            return cell
        }

    }

    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        var generalSselectedCell:UITableViewCell = tableView.cellForRowAtIndexPath(indexPath)! as UITableViewCell
        generalSselectedCell.contentView.backgroundColor = UIColor.whiteColor()
        if(indexPath.section == 1){
            var selectedCell:TagListTableViewCell = tableView.cellForRowAtIndexPath(indexPath)! as! TagListTableViewCell
            selectedCell.selectionStyle = UITableViewCellSelectionStyle.None
            if(selectedTags.containsObject(tags[indexPath.row])==false){
                selectedCell.tagList.backgroundColor = mainColor
                selectedCell.tagList.textColor = UIColor.whiteColor()
                selectedTags.addObject(tags[indexPath.row])
            }else{
                selectedCell.tagList.backgroundColor = UIColor.whiteColor()
                selectedCell.tagList.textColor = mainColor
                selectedTags.removeObject(tags[indexPath.row])
            }
        }else if(indexPath.section == 2){
            var selectedCell:TagFooterTableViewCell = tableView.cellForRowAtIndexPath(indexPath)! as! TagFooterTableViewCell
            selectedCell.selectionStyle = UITableViewCellSelectionStyle.None
        }
    }
    
    override func tableView(tableView: UITableView, didDeselectRowAtIndexPath indexPath: NSIndexPath) {
        var generalDeselectedCell:UITableViewCell = tableView.cellForRowAtIndexPath(indexPath)! as UITableViewCell
        generalDeselectedCell.contentView.backgroundColor = UIColor.whiteColor()
        if(indexPath.section == 1){
            var deselectedCell:TagListTableViewCell = tableView.cellForRowAtIndexPath(indexPath)! as! TagListTableViewCell
            deselectedCell.contentView.backgroundColor = UIColor.whiteColor()
            if(selectedTags.containsObject(tags[indexPath.row])){
                deselectedCell.tagList.backgroundColor = textColor
                deselectedCell.tagList.textColor = UIColor.whiteColor()
            }else{
                deselectedCell.tagList.backgroundColor = UIColor.whiteColor()
                deselectedCell.tagList.textColor = textColor
            }
        }
    }

    override func tableView(_tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat{
        var rowHeight:CGFloat = 0
        switch indexPath.section {
        case 0: rowHeight = 100
            break
        case 1: rowHeight = 60
            break
        case 2: rowHeight = 80
            break
        default: rowHeight = 0
            break
        }
        return rowHeight
    }
    
}
