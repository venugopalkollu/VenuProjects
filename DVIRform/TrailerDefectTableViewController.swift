//
//  TrailerDefectTableViewController.swift
//  DVIRform
//
//  Created by Lirctek on 19/06/17.
//  Copyright © 2017 Lirctek. All rights reserved.
//

import UIKit

class TrailerDefectTableViewController: UITableViewController,TrailerCheckBoxSelectded,UITextFieldDelegate {
    
    var trailerDefects :NSMutableArray = []
    var selectedIndexArrayForTrailer: NSMutableArray = []
    var trailerComments = NSMutableDictionary()
    var plistDict:NSDictionary?

    var complertionHandler:((_ valuesDict:NSMutableDictionary,_ comments:NSMutableDictionary) -> Void)?
    
    override func viewDidLoad() {
        super.viewDidLoad()
 self.tableView.delegate = self
    // Reading Plist
        let path = Bundle.main.path(forResource: "ETruckPlist", ofType: "plist")
        let dict = NSDictionary(contentsOfFile: path!)
        
        plistDict = dict!.object(forKey: "TrailerDefects") as! NSDictionary
        trailerDefects = plistDict?.allKeys as! NSMutableArray
        
        trailerDefects = trailerDefects.sorted { ($0 as! String).localizedCaseInsensitiveCompare($1 as! String) == ComparisonResult.orderedAscending } as!NSMutableArray
        self.tableView?.register(UINib(nibName:"CustomTrailerDefectsTableViewCell",bundle:nil),forCellReuseIdentifier:"TrailerDefectsCell");
        tableView.dataSource = self
        tableView.delegate = self
        
        let rightButton  = UIBarButtonItem(title: "Done", style: .plain, target: self, action: #selector(rightButtonTapped(sender:)))
        self.navigationItem.rightBarButtonItem = rightButton
//        registerKeyboardNotifications();
    }
    
    func rightButtonTapped(sender: UIBarButtonItem){
        let tempArray = NSMutableArray()
        let dict = NSMutableDictionary()
        for value in selectedIndexArrayForTrailer{
            let tempIndex = value as! Int
            let valueToDisplay = self.trailerDefects.object(at: tempIndex)
            dict.setObject(valueToDisplay, forKey: tempIndex as NSCopying)
        }
        
        self.complertionHandler!(dict, trailerComments)
        
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
        return trailerDefects.count
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TrailerDefectsCell", for: indexPath) as! CustomTrailerDefectsTableViewCell
        cell.checkBoxDelegateForTrailer = self
        cell.trailerDefectsLabel?.text = trailerDefects[indexPath.row] as? String
        cell.txtTrailerComments.delegate = self;
        cell.txtTrailerComments.tag = indexPath.row;

        if selectedIndexArrayForTrailer.contains(indexPath.row){
            
            cell.trailerCheckBoxButton.setImage(cell.checkBox, for: UIControlState.normal)
            cell.txtTrailerComments.isHidden = false
            cell.lblTrailerComments.isHidden = false
        }else{
            cell.trailerCheckBoxButton.setImage(cell.uncheckBox, for: UIControlState.normal)
            cell.txtTrailerComments.isHidden = true
            cell.lblTrailerComments.isHidden = true
            cell.txtTrailerComments.tag = indexPath.row

        }
        cell.trailerCheckBoxButton.tag = indexPath.row
        
        let defect = trailerDefects[indexPath.row]
        return cell;
    }

    func isCheckBoxSelectedForTrailer(index:Int){
        if selectedIndexArrayForTrailer.contains(index){
            self.selectedIndexArrayForTrailer.remove(index)
            let indexPath = IndexPath(item: index, section: 0)
            tableView.reloadRows(at: [indexPath], with: .automatic)
        }else{
            self.selectedIndexArrayForTrailer.add(index)
            let indexPath = IndexPath(item: index, section: 0)
            tableView.reloadRows(at: [indexPath], with: .automatic)
            
        }
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if selectedIndexArrayForTrailer.contains(indexPath.row){
            return 82
        }
        else{
            return 50
        }
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        print("venu")
    }
    func textFieldDidEndEditing(_ textField: UITextField) {
        trailerComments.setObject(textField.text!, forKey: textField.tag as NSCopying)
        
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
   
