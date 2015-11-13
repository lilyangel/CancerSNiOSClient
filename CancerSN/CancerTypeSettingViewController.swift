//
//  CancerTypeSettingViewController.swift
//  CancerSN
//
//  Created by lily on 7/24/15.
//  Copyright (c) 2015 lily. All rights reserved.
//

import UIKit

protocol CancerTypeSettingVCDelegate{
    func updateCancerType(cancerType: String)
}

protocol PathologicalSettingVCDelegate{
    func updatePathological(pathological: String)
}

class CancerTypeSettingViewController: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate{
    var isUpdate = false
    var pathologicalSettingVCDelegate: PathologicalSettingVCDelegate?
    var cancerTypeSettingVCDelegate: CancerTypeSettingVCDelegate?
    @IBOutlet weak var confirmBtn: UIButton!
    @IBOutlet weak var skipBtn: UIButton!
    @IBOutlet weak var cancerTypePickerView: UIPickerView!
    var pickerDataSource = [String]()
    var pathologicaPickerDataSource = [String]()
    let profileSet = NSUserDefaults.standardUserDefaults()
    var haalthyService = HaalthyService()
    @IBOutlet weak var pathologicalPickerView: UIPickerView!

    @IBOutlet weak var titleLabel: UILabel!
    @IBAction func cancel(sender: UIButton) {
        if (profileSet.objectForKey(userTypeUserData) as! String) == aiyouUserType{
            self.performSegueWithIdentifier("signupSegue", sender: self)
        }else{
            haalthyService.addUser(profileSet.objectForKey(userTypeUserData) as! String)
            self.dismissViewControllerAnimated(true, completion: nil)
        }
    }
    
    @IBAction func confirm(sender: UIButton) {
        var cancerType = pickerDataSource[cancerTypePickerView.selectedRowInComponent(0)]
        var selectedCancerType :String = cancerTypeMapping.objectForKey(cancerType) as! String
        if(cancerType == "肺部") && (pathologicalPickerView.hidden == true){
            pathologicalPickerView.hidden = false
        }else if(cancerType != "肺部"){
            if isUpdate {
                cancerTypeSettingVCDelegate?.updateCancerType(selectedCancerType)
                self.dismissViewControllerAnimated(true, completion: nil)
            } else {
                if (profileSet.objectForKey(userTypeUserData) as! String) == aiyouUserType{
                    self.performSegueWithIdentifier("signupSegue", sender: self)
                }else{
                    haalthyService.addUser(profileSet.objectForKey(userTypeUserData) as! String)
                    self.dismissViewControllerAnimated(true, completion: nil)
                }
            }
        }else{
            var pathological = pathologicaPickerDataSource[pathologicalPickerView.selectedRowInComponent(0)]
            var selectedPathological:String = pathologicalMapping.objectForKey(pathological) as! String
            if isUpdate {
                cancerTypeSettingVCDelegate?.updateCancerType(selectedCancerType)
                pathologicalSettingVCDelegate?.updatePathological(selectedPathological)
                self.dismissViewControllerAnimated(true, completion: nil)
            }else{
                profileSet.setObject(selectedCancerType, forKey: cancerTypeNSUserData)
                profileSet.setObject(selectedPathological, forKey: pathologicalNSUserData)
                self.performSegueWithIdentifier("geneticMutationSegue", sender: nil)
            }
        }
    }
//
//    @IBAction func selectCancerType(sender: UIButton) {
//        var cancerType = pickerDataSource[cancerTypePickerView.selectedRowInComponent(0)]
//        var selectedCancerType :String = cancerTypeMapping.objectForKey(cancerType) as! String
//        if isUpdate{
//            cancerTypeSettingVCDelegate?.updateCancerType(selectedCancerType)
//            self.dismissViewControllerAnimated(true, completion: nil)
//        }else{
//            profileSet.setObject(selectedCancerType, forKey: cancerTypeNSUserData)
//            if(cancerType == "肺部"){
//                self.performSegueWithIdentifier("showMoreForLung", sender: nil)
//            }else{
//                if (profileSet.objectForKey(userTypeUserData) as! String) == aiyouUserType{
//                    self.performSegueWithIdentifier("signupSegue", sender: self)
//                }else{
//                    haalthyService.addUser(profileSet.objectForKey(userTypeUserData) as! String)
//                    self.dismissViewControllerAnimated(true, completion: nil)
//                }
//            }
//        }
//    }
    
    override func viewDidLoad() {
        if isUpdate{
            titleLabel.hidden = true
        }
        super.viewDidLoad()
        pickerDataSource = cancerTypeMapping.allKeys as! [String]
        cancerTypePickerView.delegate = self
        cancerTypePickerView.dataSource = self
        cancerTypePickerView.selectRow(3, inComponent: 0, animated: false)
        
        pathologicaPickerDataSource = pathologicalMapping.allKeys as! [String]
        pathologicalPickerView.dataSource = self
        pathologicalPickerView.delegate = self
        pathologicalPickerView.selectRow(1, inComponent: 0, animated: false)
//        confirmBtn.layer.cornerRadius = 5
//        confirmBtn.layer.masksToBounds = true
//        skipBtn.layer.cornerRadius = 5
//        skipBtn.layer.masksToBounds = true
//        if isUpdate{
//            skipBtn.hidden = true
//        }
        
        pathologicalPickerView.hidden = true
        if isUpdate{
            confirmBtn.setTitle("确定", forState: UIControlState.Normal)
        }
    }
    
    
    func pickerView(pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusingView view: UIView!) -> UIView {
        var pickerLabel = UILabel()
        if view == nil {
            pickerLabel = UILabel(frame: CGRectMake(0, 0, 270, 32))
        }else{
            pickerLabel = view as! UILabel
        }
        pickerLabel.textAlignment = NSTextAlignment.Center
        pickerLabel.textColor = textColor
        if pickerView == cancerTypePickerView{
            pickerLabel.text = pickerDataSource[row]
        }else{
            pickerLabel.text = pathologicaPickerDataSource[row]
        }
        pickerLabel.font = UIFont.boldSystemFontOfSize(15)
        return pickerLabel
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //MARK: - Delegates and data sources
    //MARK: Data Sources
    func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int {
        return 1
    }
    func pickerView(pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if pickerView == cancerTypePickerView{
            return pickerDataSource.count
        }else{
            return pathologicaPickerDataSource.count
        }
    }
    func pickerView(pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String! {
        if pickerView == cancerTypePickerView{
            return pickerDataSource[row]
        }else{
            return pathologicaPickerDataSource[row]
        }
    }

}
