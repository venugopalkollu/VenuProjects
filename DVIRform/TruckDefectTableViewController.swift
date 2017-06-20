//
//  TruckDefectTableViewController.swift
//  DVIRform
//
//  Created by Lirctek on 19/06/17.
//  Copyright © 2017 Lirctek. All rights reserved.
//

import UIKit

class TruckDefectTableViewController: UITableViewController,CheckBoxSelectded,UITextFieldDelegate {
    
    
    var truckDefects :NSMutableArray = []
    var selectedIndexArray: NSMutableArray = []
    var complertionHandler:((_ valuesArray:NSMutableArray) -> Void)?

    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.delegate = self;
        
        truckDefects = ["Air Compressor", "Air Lines", "Audio/Visual Equimpent", "Battery", "Belts & Hoses", "Body", "Brake Accessories", "Cleanliness of Interor", "Clutch", "Condition of Floor", "Defroster", "Directional Lights", "Drivers Seat & Belt", "Emergency Door & Buzzer", "Emergency Equipment", "Engine", "Entrance Steps", "Exhaust ", "Fire Extinguisher", "First Aid Kit", "Fluid Levels", "Gauges & Warning Lights", "HeadLights", "Heater", "Horn", "Hose Connections", "Mirrors", "Muffler", "Oil Level", "Parking Brakes", "Power Steering", "Radiator Level", "Safety Equipment", "Service Brakes", "Service Door", "Starter", "Steering", "Suspension System", "Stop Arm","Switches", "Tail Lights", "Tail Pipe", "Tires", "Transmission", "Turn Indicators", "Wheelchair Lift", "Wheels & Rims", "Windows", "Windshield", "Wipers & Washers", "Other"]
            
            self.tableView?.register(UINib(nibName:"CustomTruckDefectsTableViewCell",bundle:nil),forCellReuseIdentifier:"TruckDefectsCell");
            tableView.dataSource = self
            tableView.delegate = self
        
        let rightButton  = UIBarButtonItem(title: "done", style: .plain, target: self, action: #selector(rightButtonTapped(sender:)))
        self.navigationItem.rightBarButtonItem = rightButton
        registerKeyboardNotifications()
            }
    
    func rightButtonTapped(sender: UIBarButtonItem){
        let tempArray = NSMutableArray()
        for value in selectedIndexArray{
            let tempIndex = value as! Int
            let valueToDisplay = self.truckDefects.object(at: tempIndex)
            tempArray.add(valueToDisplay)
        }
        self.complertionHandler!(tempArray)
        
        self.navigationController?.popViewController(animated: true)
        
        print("Done Button Clicked")
        
    }


    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        
        // #warning Incomplete implementation, return the number of rows
        return truckDefects.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
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
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        if selectedIndexArray.contains(indexPath.row){
            return 83
        }
        else{
            return 50
            
        }
        
    }
    
    
    
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





