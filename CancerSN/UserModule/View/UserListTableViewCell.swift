//
//  UserListTableViewCell.swift
//  CancerSN
//
//  Created by lily on 7/22/15.
//  Copyright (c) 2015 lily. All rights reserved.
//

import UIKit
import CoreData

protocol UserListDelegate {
    func performLoginSegue()
    func imageTap(username:String)
}

class UserListTableViewCell: UITableViewCell {
    
    var delegate : UserListDelegate?
    
    var hiddenFollowButton = Bool()
    var haalthyService = HaalthyService()
    
    var username = String()

    @IBOutlet weak var userImage: UIImageView!
    @IBOutlet weak var usernameDisplay: UILabel!
    @IBOutlet weak var userProfileDisplay: UILabel!
    
    @IBOutlet weak var userFollowers: UILabel!
    
    var addFollowingResponseData : NSMutableData? = nil
    var getTokenResponseData : NSMutableData? = nil
    @IBOutlet weak var addFollowingBtn: UIButton!
    
    @IBAction func addFollowing(sender: AnyObject) {
        let profileSet = NSUserDefaults.standardUserDefaults()
        if profileSet.objectForKey(accessNSUserData) != nil{
            let addFollowingData = haalthyService.addFollowing(username)
            var jsonResult = try? NSJSONSerialization.JSONObjectWithData(addFollowingData, options: NSJSONReadingOptions.MutableContainers)
//            let deleteResult = haalthyService.deleteFromSuggestedUser(usernameDisplay.text!)
//            print(NSString(data: deleteResult, encoding: NSUTF8StringEncoding))
            addFollowingBtn.enabled = false
            addFollowingBtn.setTitle("已关注", forState: UIControlState.Normal)
            addFollowingBtn.setTitleColor(UIColor.lightGrayColor(), forState: UIControlState.Normal)
            addFollowingBtn.layer.borderColor = UIColor.lightGrayColor().CGColor
//            haalthyService.increaseNewFollowCount(usernameDisplay.text!)
        }else{
            self.delegate?.performLoginSegue()
        }
    }
    
    var user=NSDictionary(){
        didSet{
            updateUI()
        }
    }
    func imageTapHandler(sender: UITapGestureRecognizer){
        self.delegate?.imageTap(user["username"] as! String)
    }
    func updateUI(){
        if((user["image"] is NSNull) == false){
            let dataString = user["image"] as! String
            let imageData: NSData = NSData(base64EncodedString: dataString, options: NSDataBase64DecodingOptions(rawValue: 0))!
            
            userImage.image = UIImage(data: imageData)
        }
        let tapImage = UITapGestureRecognizer(target: self, action: Selector("imageTapHandler:"))
        userImage.userInteractionEnabled = true
        userImage.addGestureRecognizer(tapImage)
        
        usernameDisplay.text = user["username"] as? String
        
        var userProfileStr : String
        let gender = user["gender"] as! String
        var displayGender:String = String()
        if(gender == "M"){
            displayGender = "男"
        }else if(gender == "F"){
            displayGender = "女"
        }
        var age = String()
        var stage = String()
        var cancerType = String()
        var pathological = String()
        
        if user["age"] != nil{
            age = (user["age"] as! NSNumber).stringValue
        }
//        var pathological = user["pathological"] as! String
        if (user["stage"] != nil) && !(user["stage"] is NSNull) {
            let stageStr = user["stage"]! as! Int
            let stages = stageMapping.allKeysForObject(stageStr) as NSArray
            if stages.count > 0 {
                stage = stages[0] as! String
            }
        }
        
        if (user["cancerType"] != nil) && !(user["cancerType"] is NSNull) {
            var cancerKeysForObject = cancerTypeMapping.allKeysForObject(user["cancerType"]!)
            if cancerKeysForObject.count > 0 {
                cancerType = (cancerKeysForObject)[0] as! String
            }
        }
        
        if user["pathological"] != nil && !(user["pathological"] is NSNull){
            var pathologicalKeysForObject = pathologicalMapping.allKeysForObject(user["pathological"]!)
            if pathologicalKeysForObject.count > 0 {
                pathological = pathologicalKeysForObject[0] as! String
            }
        }
        
        userProfileStr = displayGender + " " + age + "岁 " + cancerType + " " + pathological + " " + stage + "期"
        
        userProfileDisplay.text = userProfileStr
        
        userFollowers.text = (user["followCount"] as! NSNumber).stringValue + "关注"

    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
