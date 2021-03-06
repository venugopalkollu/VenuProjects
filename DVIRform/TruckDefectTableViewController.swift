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
    var truckComments = NSMutableDictionary()
    var complertionHandler:((_ valuesDict:NSMutableDictionary,_ comments:NSMutableDictionary) -> Void)?
    var plistDict:NSDictionary?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.delegate = self;
        
        //Reading Plist
        
        let path = Bundle.main.path(forResource: "ETruckPlist", ofType: "plist")
        let dict = NSDictionary(contentsOfFile: path!)
        
        plistDict = dict!.object(forKey: "TruckDefects") as? NSDictionary
        truckDefects = plistDict?.allKeys as! NSMutableArray
        
        truckDefects = truckDefects.sorted { ($0 as! String).localizedCaseInsensitiveCompare($1 as! String) == ComparisonResult.orderedAscending } as! NSMutableArray
        
        self.tableView?.register(UINib(nibName:"CustomTruckDefectsTableViewCell",bundle:nil),forCellReuseIdentifier:"TruckDefectsCell");
        tableView.dataSource = self
        tableView.delegate = self
        
        self.navigationController?.navigationBar.isTranslucent = false;
        
        let rightButton  = UIBarButtonItem(title: "Done", style: .plain, target: self, action: #selector(rightButtonTapped(sender:)))
        self.navigationItem.rightBarButtonItem = rightButton
        registerKeyboardNotifications()
    }
    
    func rightButtonTapped(sender: UIBarButtonItem){
        let tempArray = NSMutableArray()
        let dict = NSMutableDictionary()
        for value in selectedIndexArray{
            let tempIndex = value as! Int
            let valueToDisplay = self.truckDefects.object(at: tempIndex)
            dict.setObject(valueToDisplay, forKey: tempIndex as NSCopying)
        }
        self.complertionHandler!(dict,truckComments)
        
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
        cell.txtComments.delegate = self;
        cell.txtComments.tag = indexPath.row;
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
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        print("venu")

    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        truckComments.setObject(textField.text!, forKey: textField.tag as NSCopying)
        
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
                                               selector: #selector(TruckDefectTableViewController.keyboardDidShow(notification:)),
                                               name: NSNotification.Name.UIKeyboardDidShow,
                                               object: nil)
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(TruckDefectTableViewController.keyboardWillHide(notification:)),
                                               name: NSNotification.Name.UIKeyboardWillHide,
                                               object: nil)
    }
    
}





