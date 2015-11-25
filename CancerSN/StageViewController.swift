//
//  StageViewController.swift
//  CancerSN
//
//  Created by lily on 7/26/15.
//  Copyright (c) 2015 lily. All rights reserved.
//

import UIKit
protocol StageSettingVCDelegate{
    func updateStage(stage: Int)
}
protocol MetastasisSettingVCDelegate{
    func updateMetastasis(metastasis: String)
}
//class StageViewController: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate, UITextFieldDelegate {
class StageViewController: UIViewController, UITextFieldDelegate {

    var isUpdate = false
    var stageSettingVCDelegate: StageSettingVCDelegate?
    var metastasisSettingVCDelegate: MetastasisSettingVCDelegate?
    var publicService = PublicService()
    var selectedStage:Int?
    var selectedMetastasis = NSMutableArray()
    
    @IBOutlet weak var liverMetastasisBtn: UIButton!
    @IBOutlet weak var boneMetastasisBtn: UIButton!
    @IBOutlet weak var adrenalMetastasisBtn: UIButton!
    @IBOutlet weak var brainMetastasisBtn: UIButton!
    @IBOutlet weak var otherMetastasisBtn: UITextField!
    
    @IBOutlet weak var stage1Btn: UIButton!
    @IBOutlet weak var stage2Btn: UIButton!
    @IBOutlet weak var stage3Btn: UIButton!
    @IBOutlet weak var stage4Btn: UIButton!

    
    
//    @IBOutlet weak var selectBtn: UIButton!
//    
    @IBOutlet weak var titleLabel: UILabel!
//    @IBOutlet weak var skipBtn: UIButton!
//    var pickerDataSource = [String]()

//    @IBAction func selectStage(sender: UIButton) {
//        var stage = pickerDataSource[stagePickerView.selectedRowInComponent(0)]
//        var selectedStage = stageMapping.objectForKey(stage)
//        if isUpdate{
//            stageSettingVCDelegate?.updateStage(selectedStage as! Int)
//            self.dismissViewControllerAnimated(true, completion: nil)
//        }else{
//            let profileSet = NSUserDefaults.standardUserDefaults()
//            profileSet.setObject(selectedStage, forKey: stageNSUserData)
//            self.performSegueWithIdentifier("selectSmokingSegue", sender: self)
//        }
//    }
    
    @IBAction func confirm(sender: UIButton) {
        var selectedMetastasisStr = String()
        for metastasisItem in selectedMetastasis{
            selectedMetastasisStr += " " + (metastasisItem as! String)
        }
        selectedMetastasisStr += otherMetastasisBtn.text!
        if isUpdate{
            stageSettingVCDelegate?.updateStage(selectedStage!)
            metastasisSettingVCDelegate?.updateMetastasis(selectedMetastasisStr)
            self.dismissViewControllerAnimated(true, completion: nil)
        }else{
            let profileSet = NSUserDefaults.standardUserDefaults()
            profileSet.setObject(selectedStage, forKey: stageNSUserData)
            profileSet.setObject(selectedMetastasisStr, forKey: metastasisNSUserData)
            self.performSegueWithIdentifier("signupSegue", sender: self)
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
//        if isUpdate{
//            titleLabel.hidden = true
//        }
//        pickerDataSource = stageMapping.allKeys as! [String]
//        pickerDataSource = ["I","II","IV","V"]
//        stagePickerView.delegate = self
//        stagePickerView.dataSource = self
//        stagePickerView.selectRow(1, inComponent: 0, animated: false)
//        selectBtn.layer.cornerRadius = 5
//        selectBtn.layer.masksToBounds = true
//        skipBtn.layer.cornerRadius = 5
//        skipBtn.layer.masksToBounds = true
        self.navigationController?.navigationBar.hidden = false
        self.tabBarController?.tabBar.hidden = false
        publicService.unselectBtnFormat(stage1Btn)
        publicService.unselectBtnFormat(stage2Btn)
        publicService.unselectBtnFormat(stage3Btn)
        publicService.unselectBtnFormat(stage4Btn)

        publicService.unselectBtnFormat(liverMetastasisBtn)
        publicService.unselectBtnFormat(boneMetastasisBtn)
        publicService.unselectBtnFormat(adrenalMetastasisBtn)
        publicService.unselectBtnFormat(brainMetastasisBtn)
        otherMetastasisBtn.delegate = self
        
        liverMetastasisBtn.hidden = true
        boneMetastasisBtn.hidden = true
        adrenalMetastasisBtn.hidden = true
        brainMetastasisBtn.hidden = true
        otherMetastasisBtn.hidden = true
    }
    
    @IBAction func selectStage(sender: UIButton) {
        print((sender.titleLabel?.text)!)
        selectedStage = stageMapping.objectForKey((sender.titleLabel?.text)!) as! Int
        switch sender{
        case stage1Btn:
            publicService.selectedBtnFormat(stage1Btn)
            publicService.unselectBtnFormat(stage2Btn)
            publicService.unselectBtnFormat(stage3Btn)
            publicService.unselectBtnFormat(stage4Btn)
            break
        case stage2Btn:
            publicService.selectedBtnFormat(stage2Btn)
            publicService.unselectBtnFormat(stage1Btn)
            publicService.unselectBtnFormat(stage3Btn)
            publicService.unselectBtnFormat(stage4Btn)
            break
        case stage3Btn:
            publicService.selectedBtnFormat(stage3Btn)
            publicService.unselectBtnFormat(stage1Btn)
            publicService.unselectBtnFormat(stage2Btn)
            publicService.unselectBtnFormat(stage4Btn)
            break
        case stage4Btn:
            publicService.selectedBtnFormat(stage4Btn)
            publicService.unselectBtnFormat(stage1Btn)
            publicService.unselectBtnFormat(stage2Btn)
            publicService.unselectBtnFormat(stage3Btn)
            liverMetastasisBtn.hidden = false
            boneMetastasisBtn.hidden = false
            adrenalMetastasisBtn.hidden = false
            brainMetastasisBtn.hidden = false
            otherMetastasisBtn.hidden = false

            break
        default:
            break
        }
        
    }
    
    @IBAction func selectMetastasis(sender: UIButton) {
        if sender.backgroundColor == UIColor.whiteColor(){
        selectedMetastasis.addObject(metastasisMapping.objectForKey((sender.titleLabel?.text)!) as! String)
            sender.backgroundColor = mainColor
            sender.setTitleColor(UIColor.whiteColor(), forState: UIControlState.Normal)
        }else{
            selectedMetastasis.removeObject(metastasisMapping.objectForKey((sender.titleLabel?.text)!) as! String)
            sender.backgroundColor = UIColor.whiteColor()
            sender.setTitleColor(mainColor, forState: UIControlState.Normal)
        }
    }
    
    
//    func pickerView(pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusingView view: UIView!) -> UIView {
//        var pickerLabel = UILabel()
//        if view == nil {
//            pickerLabel = UILabel(frame: CGRectMake(0, 0, 270, 32))
//        }else{
//            pickerLabel = view as! UILabel
//        }
//        pickerLabel.textAlignment = NSTextAlignment.Center
//        pickerLabel.textColor = textColor
//        pickerLabel.text = pickerDataSource[row]
//        pickerLabel.font = UIFont.boldSystemFontOfSize(15)
//        return pickerLabel
//    }
//
//    override func didReceiveMemoryWarning() {
//        super.didReceiveMemoryWarning()
//        // Dispose of any resources that can be recreated.
//    }
    //MARK: - Delegates and data sources
//    //MARK: Data Sources
//    func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int {
//        return 1
//    }
//    func pickerView(pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
//        return pickerDataSource.count
//    }
//    func pickerView(pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String! {
//        return pickerDataSource[row]
//    }
    func textFieldShouldReturn(_ textField: UITextField) -> Bool{
        textField.resignFirstResponder()
        return true
    }
    
    func keyboardWillShow(sender: NSNotification) {
        self.view.frame.origin.y -= 50
    }
    func keyboardWillHide(sender: NSNotification) {
        self.view.frame.origin.y += 50
    }
}
