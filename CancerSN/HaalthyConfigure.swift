//
//  HaalthyConfigure.swift
//  CancerSN
//
//  Created by lily on 7/25/15.
//  Copyright (c) 2015 lily. All rights reserved.
//

import Foundation
import UIKit

//restful service URL setting

let haalthyServiceRestfulURL : String = "http://127.0.0.1:8080/haalthyservice/"

let getSuggestUserByTagsURL = haalthyServiceRestfulURL + "open/user/suggestedusers"
let getTagListURL = haalthyServiceRestfulURL + "open/tag/list"
let addNewUserURL = haalthyServiceRestfulURL + "open/user/add"
let getOauthTokenURL = haalthyServiceRestfulURL + "oauth/token?client_id=my-trusted-client&grant_type=password&"
let addFollowingURL = haalthyServiceRestfulURL + "security/user/follow/add/"
let getUserFavTagsURL = haalthyServiceRestfulURL + "security/user/tags"
let getBroadcastsByTagsURL = haalthyServiceRestfulURL + "open/post/tags"
let updateFavTagsURL = haalthyServiceRestfulURL + "security/user/tag/update"
let addCommentsURL = haalthyServiceRestfulURL + "security/comment/add"
let getCommentListByPostURL  = haalthyServiceRestfulURL + "open/comment/post/"
let getPostByIdURL = haalthyServiceRestfulURL + "open/post/"
let addPostURL = haalthyServiceRestfulURL + "security/post/add"
let getFeedsURL = haalthyServiceRestfulURL + "security/post/posts"
let getTreatmentsURL = haalthyServiceRestfulURL + "open/patient/treatments/"
let getTreatmentformatURL = haalthyServiceRestfulURL + "open/patient/treatmentformat"
let addTreatmentURL = haalthyServiceRestfulURL + "security/patient/treatment/add"
let getPatientStatusFormatURL = haalthyServiceRestfulURL + "open/patient/patientstatusformat"
let addPatientStatusURL = haalthyServiceRestfulURL + "security/patient/patientStatus/add"
let getMyProfileURL = haalthyServiceRestfulURL + "security/user/"
let getSuggestUserByProfileURL:String = haalthyServiceRestfulURL + "security/user/suggestedusers"

//store info in keychain
let usernameKeyChain = "haalthyUsernameIdentifier"
let passwordKeyChain = "haalthyPasswordIdentifier"

//store info in NSUserData
let favTagsNSUserData = "favoriteTags"
let genderNSUserData = "haalthyUserGender"
let ageNSUserData = "haalthyUserAge"
let cancerTypeNSUserData = "haalthyUserCancertype"
let pathologicalNSUserData = "haalthyUserPathological"
let stageNSUserData = "haalthyUserStage"
let smokingNSUserData = "haalthyUserSmoking"
let metastasisNSUserData = "haalthyUserMetastasis"
let emailNSUserData = "haalthyUserEmail"
let accessNSUserData = "haalthyUserAccessToken"
let refreshNSUserData = "haalthyUserRefreshToken"
let imageNSUserData = "haalthyUserImageToken"

let newTreatmentBegindate = "haalthyNewTreatmentBeginDate"
let newTreatmentEnddate = "haalthyNewTreatmentEndDate"

//store ImageFilename
let imageFileName = "portrait.jpg"

//UI Displayname<--> Database Mapping
let genderMapping = NSDictionary(objects:["M","F"], forKeys:["男","女"])
let cancerTypeMapping = NSDictionary(objects: ["liver", "kidney", "lung", "bravery", "intestine", "stomach", "female", "blood"], forKeys: ["肝部", "肾部", "肺部", "胆管", "肠部", "胃部", "妇科", "血液"])
let pathologicalMapping = NSDictionary(objects: ["adenocarcinoma","carcinoma","AdenosquamousCarcinoma"], forKeys: ["腺癌","鳞癌","腺鳞癌"])
let stageMapping = NSDictionary(objects: [1,2,3,4], forKeys: ["I","II","IV","V"])
let smokingMapping = NSDictionary(objects: [0,1], forKeys: ["否","是"])
let metastasisMapping = NSDictionary(objects: ["liver","bone","adrenal","brain"], forKeys: ["肝转移","骨转移","肾上腺转移","脑转移"])

//
let latestBroadcastUpdateTimestamp = "haalthyLatestBroadcastUpdateTimestamp"
let latestFeedsUpdateTimestamp = "haalthyLatestFeedsUpdateTimestamp"

//
let headerColor : UIColor = UIColor.init(red:0.15, green:0.67, blue:0.8, alpha:0.9)
let tabBarColor : UIColor = UIColor.init(red:0.1, green:0.6, blue:0.7, alpha:0.3)
let highlightColor : UIColor = UIColor.init(red:0.15, green:0.75, blue:0.85, alpha:1)
let textColor : UIColor = UIColor.init(red:0.28, green:0.75, blue:0.85, alpha:1)
let lightBackgroundColor : UIColor = UIColor.init(red:0.15, green:0.75, blue:0.85, alpha:0.4)
let mainColor : UIColor = UIColor.init(red:0.28, green:0.75, blue:0.85, alpha:1)






