//
//  PathologicalSetingViewController.swift
//  CancerSN
//
//  Created by lily on 7/26/15.
//  Copyright (c) 2015 lily. All rights reserved.
//

import UIKit

class PathologicalSetingViewController: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate{

    @IBOutlet weak var pathologicalPickerView: UIPickerView!

    var pickerDataSource = [String]()

    @IBAction func selectPathological(sender: UIButton) {
        let profileSet = NSUserDefaults.standardUserDefaults()
        var pathological = pickerDataSource[pathologicalPickerView.selectedRowInComponent(0)]
        var selectedPathological:String = pathologicalMapping.objectForKey(pathological) as! String
        profileSet.setObject(selectedPathological, forKey: pathologicalNSUserData)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        pickerDataSource = pathologicalMapping.allKeys as! [String]
        pathologicalPickerView.dataSource = self
        pathologicalPickerView.delegate = self
        pathologicalPickerView.selectRow(1, inComponent: 0, animated: false)
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
        return pickerDataSource.count
    }
    func pickerView(pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String! {
        return pickerDataSource[row]
    }


}