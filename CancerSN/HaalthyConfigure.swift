//
//  HaalthyConfigure.swift
//  CancerSN
//
//  Created by lily on 7/25/15.
//  Copyright (c) 2015 lily. All rights reserved.
//

import Foundation

//restful service URL setting

let haalthyServiceRestfulURL : String = "http://localhost:8080/haalthyservice/"

let getSuggestUserByTagsURL = haalthyServiceRestfulURL + "open/user/suggestedusers"
let getTagListURL = haalthyServiceRestfulURL + "open/tag/list"
let addNewUserURL = haalthyServiceRestfulURL + "open/user/add"

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


//UI Displayname<--> Database Mapping
let genderMapping = NSDictionary(objects:["M","F"], forKeys:["男","女"])
let cancerTypeMapping = NSDictionary(objects: ["liver", "kidney", "lung", "bravery", "intestine", "stomach", "female", "blood"], forKeys: ["肝部", "肾部", "肺部", "胆管", "肠部", "胃部", "妇科", "血液"])
let pathologicalMapping = NSDictionary(objects: ["adenocarcinoma","carcinoma","AdenosquamousCarcinoma"], forKeys: ["腺癌","鳞癌","腺鳞癌"])
let stageMapping = NSDictionary(objects: [1,2,3,4], forKeys: ["I","II","IV","V"])
let smokingMapping = NSDictionary(objects: [0,1], forKeys: ["否","是"])
let metastasisMapping = NSDictionary(objects: ["liver","bone","adrenal","brain"], forKeys: ["肝转移","骨转移","肾上腺转移","脑转移"])
