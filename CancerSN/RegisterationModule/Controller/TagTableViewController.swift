//
//  TagTableViewController.swift
//  CancerSN
//
//  Created by lily on 9/24/15.
//  Copyright (c) 2015 lily. All rights reserved.
//

import UIKit

protocol UserTagVCDelegate {
    func updateUserTagList(data: NSArray)
}

protocol PostTagVCDelegate{
    func getPostTagList(data: NSArray)
}

class TagTableViewController: UITableViewController {
    var userTagDelegate: UserTagVCDelegate?
    var postDelegate: PostTagVCDelegate?

    var haalthyService = HaalthyService()
    var publicService = PublicService()
    var keychain = KeychainAccess()
    var isBroadcastTagSelection = 0
    var selectedTags = NSMutableArray()
    var selectedTagsStr = NSMutableSet()
    var tagList = NSArray()
    var tagTypeList = NSArray()
    var groupedTagList = NSMutableArray()
    var rowHightForTagContainer = NSMutableArray()
    var isFirstTagSelection = false

    @IBAction func cancel(sender: UIButton) {
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    @IBAction func submit(sender: UIButton) {
        selectedTags.removeAllObjects()
        for var index = 0; index < tagList.count; ++index{
            if selectedTagsStr.containsObject((tagList[index] as! NSDictionary).objectForKey("name") as! String){
                selectedTags.addObject(tagList[index])
            }
        }
        if isBroadcastTagSelection == 0 {
            var profileSet = NSUserDefaults.standardUserDefaults()
            NSUserDefaults.standardUserDefaults().setObject(selectedTags, forKey: favTagsNSUserData)
            if(keychain.getPasscode(usernameKeyChain) != nil && keychain.getPasscode(passwordKeyChain) != nil && (keychain.getPasscode(usernameKeyChain) as! String) != ""){
                var updateUserTagsRespData = haalthyService.updateUserTag(selectedTags)
            }
            userTagDelegate?.updateUserTagList(selectedTags)
            if isFirstTagSelection {
                if (profileSet.objectForKey(userTypeUserData) == nil) || (profileSet.objectForKey(userTypeUserData) as! String) != aiyouUserType{
                    let storyboard = UIStoryboard(name: "Main", bundle: nil)
                    let controller = storyboard.instantiateViewControllerWithIdentifier("MainEntry") as UIViewController
                    self.presentViewController(controller, animated: true, completion: nil)
                }else{
                    self.performSegueWithIdentifier("signupSegue", sender: self)
                }
            }else{
                self.dismissViewControllerAnimated(true, completion: nil)
            }
        }else{
            self.postDelegate?.getPostTagList(self.selectedTags)
            self.dismissViewControllerAnimated(true, completion: nil)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let getTagListRespData:NSData? = haalthyService.getTagList()
        if getTagListRespData != nil{
            let jsonResult = try? NSJSONSerialization.JSONObjectWithData(getTagListRespData!, options: NSJSONReadingOptions.MutableContainers)
            if(jsonResult is NSArray){
//                tagList = jsonResult as! NSArray
//                let tagTypeSet = NSMutableSet()
//                
//                for tagItem in tagList{
//                    let tag = tagItem as! NSDictionary
//                    var groupedTagsItem = NSMutableDictionary()
//                    if tagTypeSet.containsObject(tag.objectForKey("typeName")!){
//                        for groupedTag in groupedTagList{
//                            let groupedTagItem = groupedTag as! NSMutableDictionary
//                            if (groupedTagItem.objectForKey("typeName") as! String) == (tag.objectForKey("typeName") as! String){
//                                let tagListsInGroup = NSMutableArray(array: groupedTagItem.objectForKey("tagsInGroup") as! NSArray)
//                                tagListsInGroup.addObject(tag)
//                                groupedTagItem.setObject(tagListsInGroup, forKey: "tagsInGroup")
//                                break
//                            }
//                        }
//                    }else {
//                        tagTypeSet.addObject(tag.objectForKey("typeName")!)
//                        let groupedTagItem = NSMutableDictionary()
//                        groupedTagItem.setObject(tag.objectForKey("typeName")!, forKey: "typeName")
//                        groupedTagItem.setObject(tag.objectForKey("typeRank")!, forKey: "typeRank")
//                        groupedTagItem.setObject(NSArray(array: [tag]), forKey: "tagsInGroup")
//                        groupedTagList.addObject(groupedTagItem)
//                    }
//                }
//                tagTypeList = NSArray(array: tagTypeSet.allObjects)
//                let descriptor: NSSortDescriptor = NSSortDescriptor(key: "typeRank", ascending: true)
//                groupedTagList = NSMutableArray(array: groupedTagList.sortedArrayUsingDescriptors([descriptor]))
                groupedTagList = jsonResult as! NSMutableArray
                let descriptor: NSSortDescriptor = NSSortDescriptor(key: "typeRank", ascending: true)
                groupedTagList = NSMutableArray(array: groupedTagList.sortedArrayUsingDescriptors([descriptor]))
            }
            
            for groupedTag in groupedTagList {
//                if groupedTag.objectForKey("tagsInGroup")!.count <= 5{
                if groupedTag.objectForKey("tags")!.count <= 5{

                    rowHightForTagContainer.addObject(40)
                }else{
                    rowHightForTagContainer.addObject(80)
                }
            }
            
            if (selectedTagsStr.count == 0) && (isBroadcastTagSelection == 0) && (isFirstTagSelection == false){
                if (keychain.getPasscode(usernameKeyChain) != nil)  {
                    let getUserFavTagsData: NSData? = haalthyService.getUserFavTags()
                    if getUserFavTagsData != nil{
                        let jsonResult = try? NSJSONSerialization.JSONObjectWithData(getUserFavTagsData!, options: NSJSONReadingOptions.MutableContainers)
                        selectedTags = jsonResult as! NSMutableArray
                    }
                }else{
                    selectedTags = NSUserDefaults.standardUserDefaults().objectForKey(favTagsNSUserData) as! NSMutableArray
                }
                for favTag in selectedTags{
                    selectedTagsStr.addObject(favTag.objectForKey("name") as! String)
                }
            }
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
        return groupedTagList.count + 2
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let numberOfRows = 1
        return numberOfRows
    }

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        if indexPath.section == 0{
            
            let cell = tableView.dequeueReusableCellWithIdentifier("tagHeaderCell", forIndexPath: indexPath) as! TagHeaderTableViewCell
            if isBroadcastTagSelection == 1{
                cell.header.text = "请选择发布问题的标签"
                cell.cancelBtn.hidden = true
            }else{
                cell.cancelBtn.hidden = false
                cell.header.text = "请选择您关注的标签"
            }
            cell.header.textColor = textColor
            return cell
            
        } else if (indexPath.section == groupedTagList.count+1){
            let cell = tableView.dequeueReusableCellWithIdentifier("submitCell", forIndexPath: indexPath) 
            return cell
        }
        else{
            let cell = tableView.dequeueReusableCellWithIdentifier("tagContainerCell", forIndexPath: indexPath) 
//            let groupedTagsInType = (groupedTagList[indexPath.section - 1] as! NSDictionary).objectForKey("tagsInGroup") as! NSArray
            let groupedTagsInType = (groupedTagList[indexPath.section - 1] as! NSDictionary).objectForKey("tags") as! NSArray
            var index: Int = 0
            let tagButtonHeight: CGFloat = 30
            let tagButtonWidth: CGFloat = (cell.frame.width - 20)/5 - 5
            for tag in groupedTagsInType {
                let tagItem = tag as! NSDictionary
                let coordinateX = 10 + CGFloat(index%5) * (tagButtonWidth + 5)
                var coordinateY:CGFloat = 5
                if index >= 5 {
                    coordinateY = 40
                }
                let tagButton = UIButton(frame: CGRectMake(coordinateX, coordinateY, tagButtonWidth, tagButtonHeight))
                cell.addSubview(tagButton)
                publicService.formatButton(tagButton, title: tagItem.objectForKey("name") as! String)
                tagButton.titleLabel?.font = UIFont(name: fontStr, size: 12.0)
                index++
                if selectedTagsStr.containsObject(tagItem.objectForKey("name") as! String){
                    tagButton.setTitleColor(UIColor.whiteColor(), forState: UIControlState.Normal)
                    tagButton.backgroundColor = mainColor
                }
                tagButton.addTarget(self, action: Selector("addSelectedTags:") , forControlEvents: UIControlEvents.TouchUpInside)
            }
        return cell
        }
    }
    
    func addSelectedTags(sender: UIButton){
        if sender.backgroundColor == UIColor.whiteColor() {
            sender.backgroundColor = mainColor
            sender.setTitleColor(UIColor.whiteColor(), forState: UIControlState.Normal)
            selectedTagsStr.addObject((sender.titleLabel?.text)!)
        }else{
            sender.backgroundColor = UIColor.whiteColor()
            sender.setTitleColor(mainColor, forState: UIControlState.Normal)
            selectedTagsStr.removeObject((sender.titleLabel?.text)!)
        }
    }
    
    override func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        var heightForHeader:CGFloat = 0
        if section > 0 && section < groupedTagList.count + 1{
            heightForHeader = 50
        }
        return heightForHeader
    }

    override func tableView (tableView:UITableView,  viewForHeaderInSection section:Int)->UIView {
        var headerView = UIView()
        if section > 0 && section < groupedTagList.count + 1{
            headerView =  UIView(frame: CGRectMake(0, 0,self.tableView.bounds.size.width, 40))
            let tagTypeLabel = UILabel(frame: CGRectMake(15, 10, self.tableView.bounds.size.width - 30, 30))
            tagTypeLabel.text = (groupedTagList[section-1] as! NSDictionary).objectForKey("typeName") as? String
            tagTypeLabel.textColor = mainColor
            tagTypeLabel.font = UIFont(name: fontStr, size: 15.0)
            headerView.addSubview(tagTypeLabel)
        }
        return headerView
    }
    
    override func tableView(_tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat{
        var heightForRow: CGFloat = 80
        if indexPath.section > 0 && indexPath.section < groupedTagList.count + 1{
            heightForRow = (rowHightForTagContainer[indexPath.section - 1] as! CGFloat)
        }
        return heightForRow
    }
    

}
