//
//  HaalthyService.swift
//  CancerSN
//
//  Created by lily on 8/4/15.
//  Copyright (c) 2015 lily. All rights reserved.
//

import Foundation

class HaalthyService:NSObject{

    func addPost(post : NSDictionary)->NSData{
        var accessToken = NSUserDefaults.standardUserDefaults().objectForKey(accessNSUserData)
        if accessToken == nil {
            let getAccessToken = GetAccessToken()
            getAccessToken.getAccessToken()
            accessToken = NSUserDefaults.standardUserDefaults().objectForKey(accessNSUserData)
        }
        let urlPath:String = (addPostURL as String) + "?access_token=" + (accessToken as! String);
        println(urlPath)
        let url : NSURL = NSURL(string: urlPath)!
        let request = NSMutableURLRequest(URL: url)
        request.HTTPMethod = "POST"
        var response: AutoreleasingUnsafeMutablePointer<NSURLResponse?> = nil
        request.HTTPBody = NSJSONSerialization.dataWithJSONObject(post, options: NSJSONWritingOptions.allZeros, error: nil)
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        var addPostRespData = NSURLConnection.sendSynchronousRequest(request, returningResponse: response, error: nil)
        return addPostRespData!
    }
    
    func addUser()->NSData{
        //upload UserInfo to Server
        let keychainAccess = KeychainAccess()
        let profileSet = NSUserDefaults.standardUserDefaults()
        var addUserBody = NSDictionary(objects: [(profileSet.objectForKey(emailNSUserData))!, (keychainAccess.getPasscode(usernameKeyChain))!, (keychainAccess.getPasscode(passwordKeyChain))!, (profileSet.objectForKey(genderNSUserData))!, (profileSet.objectForKey(smokingNSUserData))!, (profileSet.objectForKey(pathologicalNSUserData))!, (profileSet.objectForKey(stageNSUserData))!, (profileSet.objectForKey(ageNSUserData))!, (profileSet.objectForKey(cancerTypeNSUserData))!, (profileSet.objectForKey(metastasisNSUserData))!,(profileSet.objectForKey(imageNSUserData))!], forKeys: ["email", "username","password", "gender", "isSmoking", "pathological", "stage", "age", "cancerType", "metastasis","image"])
        let addUserUrl = NSURL(string: addNewUserURL)
        let request: NSMutableURLRequest = NSMutableURLRequest(URL: addUserUrl!)
        request.HTTPMethod = "POST"
        request.HTTPBody = NSJSONSerialization.dataWithJSONObject(addUserBody, options:  NSJSONWritingOptions.allZeros, error: nil)
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        return NSURLConnection.sendSynchronousRequest(request,returningResponse: nil,error: nil)!
//        var connection: NSURLConnection = NSURLConnection(request: request, delegate: self, startImmediately: true)!
    }
    
    func getFeeds()->NSData{
        let getAccessToken = GetAccessToken()
        getAccessToken.getAccessToken()
        let accessToken = NSUserDefaults.standardUserDefaults().objectForKey(accessNSUserData)
        let urlPath:String = (getFeedsURL as String) + "?access_token=" + (accessToken as! String);
        println(urlPath)
        let url : NSURL = NSURL(string: urlPath)!
        let request = NSMutableURLRequest(URL: url)
        request.HTTPMethod = "POST"
        var profileSet = NSUserDefaults.standardUserDefaults()
        var requestBody = NSMutableDictionary()
        if((profileSet.objectForKey(latestFeedsUpdateTimestamp)) != nil){
            requestBody.setValue(Int((profileSet.objectForKey(latestFeedsUpdateTimestamp) as! Float)*1000), forKey: "begin")
        }else{
            requestBody.setValue(0, forKey: "begin")
        }
        println(NSDate().timeIntervalSince1970)
        println(Int(NSDate().timeIntervalSince1970*100000))
        requestBody.setValue(Int(NSDate().timeIntervalSince1970*100000), forKey: "end")
        request.HTTPBody = NSJSONSerialization.dataWithJSONObject(requestBody, options: NSJSONWritingOptions.allZeros, error: nil)
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        return NSURLConnection.sendSynchronousRequest(request,returningResponse: nil,error: nil)!
    }
    
    func getTreatments(username : String)->NSData{
        let urlPath = getTreatmentsURL + "/{" + username + "}"
        let url : NSURL = NSURL(string: urlPath)!
        let request = NSMutableURLRequest(URL: url)
        request.HTTPMethod = "GET"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        return NSURLConnection.sendSynchronousRequest(request,returningResponse: nil,error: nil)!
    }
    
    func getTreatmentFormat()->NSData{
        let url:NSURL = NSURL(string: getTreatmentformatURL)!
        let request = NSMutableURLRequest(URL: url)
        request.HTTPMethod = "GET"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        return NSURLConnection.sendSynchronousRequest(request,returningResponse: nil,error: nil)!
    }
    
    func getPatientStatusFormat()->NSData{
        let url:NSURL = NSURL(string: getPatientStatusFormatURL)!
        let request = NSMutableURLRequest(URL: url)
        request.HTTPMethod = "GET"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        return NSURLConnection.sendSynchronousRequest(request,returningResponse: nil,error: nil)!
    }
    
    func addTreatment(treatmentList:NSArray)->NSData{
        var accessToken = NSUserDefaults.standardUserDefaults().objectForKey(accessNSUserData)
        if accessToken == nil {
            let getAccessToken = GetAccessToken()
            getAccessToken.getAccessToken()
            accessToken = NSUserDefaults.standardUserDefaults().objectForKey(accessNSUserData)
        }
        let urlPath:String = (addTreatmentURL as String) + "?access_token=" + (accessToken as! String);
        println(urlPath)
        let url : NSURL = NSURL(string: urlPath)!
        let request = NSMutableURLRequest(URL: url)
        request.HTTPMethod = "POST"
        var response: AutoreleasingUnsafeMutablePointer<NSURLResponse?> = nil
        var treatments = NSMutableDictionary()
        treatments.setObject(treatmentList, forKey: "treatments")
        request.HTTPBody = NSJSONSerialization.dataWithJSONObject(treatments, options: NSJSONWritingOptions.allZeros, error: nil)
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        var addTreatmentRespData = NSURLConnection.sendSynchronousRequest(request, returningResponse: response, error: nil)
        
        let str: NSString = NSString(data: addTreatmentRespData!, encoding: NSUTF8StringEncoding)!
        println(str)
        let inputStr: NSString = NSString(data: request.HTTPBody!, encoding: NSUTF8StringEncoding)!
        println(inputStr)
        return addTreatmentRespData!
    }
    
    func addPatientStatus(patientStatus:NSDictionary)->NSData{
        var accessToken = NSUserDefaults.standardUserDefaults().objectForKey(accessNSUserData)
        if accessToken == nil {
            let getAccessToken = GetAccessToken()
            getAccessToken.getAccessToken()
            accessToken = NSUserDefaults.standardUserDefaults().objectForKey(accessNSUserData)
        }
        let urlPath:String = (addPatientStatusURL as String) + "?access_token=" + (accessToken as! String);
        println(urlPath)
        let url : NSURL = NSURL(string: urlPath)!
        let request = NSMutableURLRequest(URL: url)
        request.HTTPMethod = "POST"
        var response: AutoreleasingUnsafeMutablePointer<NSURLResponse?> = nil
        var treatments = NSMutableDictionary()
        request.HTTPBody = NSJSONSerialization.dataWithJSONObject(patientStatus, options: NSJSONWritingOptions.allZeros, error: nil)
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        var addPatientStatusRespData = NSURLConnection.sendSynchronousRequest(request, returningResponse: response, error: nil)
        
        let str: NSString = NSString(data: addPatientStatusRespData!, encoding: NSUTF8StringEncoding)!
        println(str)
        let inputStr: NSString = NSString(data: request.HTTPBody!, encoding: NSUTF8StringEncoding)!
        println(inputStr)
        return addPatientStatusRespData!
    }
    
}