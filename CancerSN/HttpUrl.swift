//
//  HttpUrl.swift
//  CancerSN
//
//  Created by lay on 15/12/16.
//  Copyright © 2015年 lily. All rights reserved.
//

import Foundation

//restful service URL setting

let haalthyServiceRestfulURL : String = "http://127.0.0.1:8080/haalthyservice/"
let haalthyServiceSolrURL : String = "http://localhost:8983/solr/aiyoupost/"
let queryPostBodyURL = haalthyServiceSolrURL + "select?wt=jason&indent=true&q=body%3A"

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
let getClinicReportFormatURL = haalthyServiceRestfulURL + "open/patient/clinicreportformat"
let addPatientStatusURL = haalthyServiceRestfulURL + "security/patient/patientStatus/add"
let getMyProfileURL = haalthyServiceRestfulURL + "security/user/"
let getSuggestUserByProfileURL:String = haalthyServiceRestfulURL + "security/user/suggestedusers"
let getUserDetailURL:String = haalthyServiceRestfulURL + "security/user/detail"
let getPostsByUsernameURL:String = haalthyServiceRestfulURL + "security/post/posts"
let resetPasswordURL:String = haalthyServiceRestfulURL + "security/user/resetpassword"
let getFollowingUserURL:String = haalthyServiceRestfulURL + "security/user/followingusers"
let getFollowerUserURL:String = haalthyServiceRestfulURL + "security/user/followerusers"
let getCommentsByUsernameURL:String = haalthyServiceRestfulURL + "security/post/comments"
let updateUserURL: String = haalthyServiceRestfulURL + "security/user/update"
let deleteFromSuggestedUserURL: String = haalthyServiceRestfulURL + "security/user/deletesuggesteduser"
let getUpdatedPostCountURL: String = haalthyServiceRestfulURL + "security/post/postcount"
let getBroadcastsByTagsCountURL = haalthyServiceRestfulURL + "open/post/tags/count"
let updateTreatmentURL = haalthyServiceRestfulURL + "security/patient/treatment/update"
let deleteTreatmentURL = haalthyServiceRestfulURL + "security/patient/treatment/delete"
let increaseNewFollowCountURL = haalthyServiceRestfulURL + "security/user/newfollow/increase"
let selectNewFollowCountURL = haalthyServiceRestfulURL + "security/user/newfollow/count"
let refreshNewFollowCountURL = haalthyServiceRestfulURL + "security/user/newfollow/refresh"
let isFollowingUserURL = haalthyServiceRestfulURL + "security/user/follow/isfollowing"
let getUnreadMentionedPostCountURL = haalthyServiceRestfulURL + "security/post/mentionedpost/unreadcount"
let getMentionedPostListURL = haalthyServiceRestfulURL + "security/post/mentionedpost/list"
let markMentionedPostAsReadURL = haalthyServiceRestfulURL + "security/post/mentionedpost/markasread"
let getUsernameByEmailURL = haalthyServiceRestfulURL + "security/user/getusername"
let getUsersByDisplaynameURL = haalthyServiceRestfulURL + "security/user/getusersbydisplayname"

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
let geneticMutationNSUserData = "haalthyUserGeneticMutation"
let emailNSUserData = "haalthyUserEmail"
let accessNSUserData = "haalthyUserAccessToken"
let refreshNSUserData = "haalthyUserRefreshToken"
let imageNSUserData = "haalthyUserImageToken"
let displaynameUserData = "haalthyUserDisplayname"
let userTypeUserData = "haalthyUserType"
let qqUserType = "QQ"
let aiyouUserType = "AY"
let wechatUserType = "WC"

let newTreatmentBegindate = "haalthyNewTreatmentBeginDate"
let newTreatmentEnddate = "haalthyNewTreatmentEndDate"


//store ImageFilename
let imageFileName = "portrait.jpg"

//UI Displayname<--> Database Mapping
let genderMapping = NSDictionary(objects:["M","F"], forKeys:["男","女"])
let cancerTypeMapping = NSDictionary(objects: ["liver", "kidney", "lung", "bravery", "intestine", "stomach", "female", "blood"], forKeys: ["肝部", "肾部", "肺部", "胆管", "肠部", "胃部", "妇科", "血液"])
let pathologicalMapping = NSDictionary(objects: ["adenocarcinoma","carcinoma","AdenosquamousCarcinoma","smallcell"], forKeys: ["腺癌","鳞癌","腺鳞癌","小细胞"])
let stageMapping = NSDictionary(objects: [1,2,3,4], forKeys: ["I","II","III","IV"])
let smokingMapping = NSDictionary(objects: [0,1], forKeys: ["否","是"])
let metastasisMapping = NSDictionary(objects: ["liver","bone","adrenal","brain"], forKeys: ["肝转移","骨转移","肾上腺转移","脑转移"])
let geneticMutationMapping = NSDictionary(objects: ["KRAS", "EGFR", "ALK", "OTHERS", "NONE"], forKeys: ["KRAS","EGFR","ALK","其他","没有基因突变"])

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
let sectionHeaderColor: UIColor = UIColor.init(red:0.15, green:0.67, blue:0.8, alpha:0.2)

let fontStr: String = "Helvetica"

let defaultTreatmentEndDate: NSTimeInterval = 1767225600



