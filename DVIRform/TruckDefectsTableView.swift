//
//  TruckDefectsTableView.swift
//  DVIRform
//
//  Created by Lirctek on 09/06/17.
//  Copyright © 2017 Lirctek. All rights reserved.
//

import UIKit

class TruckDefectsTableView: UIView, UITableViewDelegate, UITableViewDataSource,CheckBoxSelectded, UITextFieldDelegate{
    
    @IBOutlet weak var tableView: UITableView!
    
  
    @IBOutlet weak var backButton: UIBarButtonItem!
    
    @IBOutlet weak var doneButton: UIBarButtonItem!
    
    
    @IBAction func backButtonClicked(_ sender: Any) {
        
        
        
        
    }
    
    @IBAction func doneButtonClicked(_ sender: Any) {
        
        
        
        
        
        print("Done clicked")
    }
    
    var truckDefects :NSMutableArray = []
    var selectedIndexArray: NSMutableArray = []
    var dict : NSMutableDictionary=[:]
    class func instanceFromNib() -> UIView {
        return UINib(nibName: "TruckDefectsTableView", bundle: nil).instantiate(withOwner: nil, options: nil)[0] as! TruckDefectsTableView
    }
    
    func allocateArray(){
        truckDefects = ["Air Compressor", "Air Lines", "Audio/Visual Equimpent", "Battery", "Belts & Hoses", "Body", "Brake Accessories", "Cleanliness of Interor", "Clutch", "Condition of Floor", "Defroster", "Directional Lights", "Drivers Seat & Belt", "Emergency Door & Buzzer", "Emergency Equipment", "Engine", "Entrance Steps", "Exhaust ", "Fire Extinguisher", "First Aid Kit", "Fluid Levels", "Gauges & Warning Lights", "HeadLights", "Heater", "Horn", "Hose Connections", "Mirrors", "Muffler", "Oil Level", "Parking Brakes", "Power Steering", "Radiator Level", "Safety Equipment", "Service Brakes", "Service Door", "Starter", "Steering", "Suspension System", "Stop Arm","Switches", "Tail Lights", "Tail Pipe", "Tires", "Transmission", "Turn Indicators", "Wheelchair Lift", "Wheels & Rims", "Windows", "Windshield", "Wipers & Washers", "Other"]
        
        self.tableView?.register(UINib(nibName:"CustomTruckDefectsTableViewCell",bundle:nil),forCellReuseIdentifier:"TruckDefectsCell");
        tableView.dataSource = self
        tableView.delegate = self
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return truckDefects.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TruckDefectsCell", for: indexPath) as! CustomTruckDefectsTableViewCell
        cell.checkBoxDelegate = self
        cell.truckDefectLabel?.text = truckDefects[indexPath.row] as? String
        if selectedIndexArray.contains(indexPath.row){
            cell.checkBoxButton.setImage(cell.checkBox, for: UIControlState.normal)
            cell.txtComments.isHidden = false
            cell.lblComments.isHidden = false

            
        }else{
            cell.checkBoxButton.setImage(cell.uncheckBox, for: UIControlState.normal)
            cell.txtComments.isHidden = true
            cell.lblComments.isHidden = true
            cell.txtComments.tag = indexPath.row
        }
        cell.checkBoxButton.tag = indexPath.row
        let defects = truckDefects[indexPath.row]
        return cell;
    }
    
    func isCheckBoxSelected(index:Int){
        if(selectedIndexArray.contains(index)){
            self.selectedIndexArray.remove(index)
            let indexPath = IndexPath(item: index, section: 0)
            tableView.reloadRows(at: [indexPath], with: .automatic)
            
        }else{
            self.selectedIndexArray.add(index)
            let indexPath = IndexPath(item: index, section: 0)
            tableView.reloadRows(at: [indexPath], with: .automatic)
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        if selectedIndexArray.contains(indexPath.row){
            return 83
        }
        else{
            return 50

        }
     
    }
    
    func appendDefects() {
        
        
        
    }
    
   let navigationController = UINavigationController()

    
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    
    func keyboardDidShow(notification: NSNotification)
    {
        
        var userInfo = notification.userInfo!
        var keyboardFrame:CGRect = (userInfo[UIKeyboardFrameBeginUserInfoKey] as! NSValue).cgRectValue
        keyboardFrame = self.tableView.convert(keyboardFrame, from: nil)
        
        var contentInset:UIEdgeInsets = self.tableView.contentInset
        contentInset.bottom = keyboardFrame.size.height + 10;
        self.tableView.contentInset = contentInset
        //if let userInfo = notification.userInfo
    }
    
    /**
     This method is fired when the keyboard is hidden.
     */
    func keyboardWillHide(notification: NSNotification){
        let contentInset:UIEdgeInsets = UIEdgeInsets.zero
        self.tableView.contentInset = contentInset
    }
    
    func registerKeyboardNotifications() {
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(TruckDefectsTableView.keyboardDidShow(notification:)),
                                               name: NSNotification.Name.UIKeyboardDidShow,
                                               object: nil)
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(TruckDefectsTableView.keyboardWillHide(notification:)),
                                               name: NSNotification.Name.UIKeyboardWillHide,
                                               object: nil)
    }
    
}

