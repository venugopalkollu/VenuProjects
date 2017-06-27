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

    var complertionHandler:((_ valuesDict:NSMutableDictionary,_ comments:NSMutableDictionary) -> Void)?
    
    override func viewDidLoad() {
        super.viewDidLoad()
 self.tableView.delegate = self
        trailerDefects = ["Brake Connections", "Brakes", "Coupling Devices", "Coupling Pin", "Doors", "Hitch", "Landing Gear", "Lights", "Reflectors", "Roof", "Straps", "Suspection System", "Tarpaulin", "Tires", "Wheels & Rims", "Other"]
        
        self.tableView?.register(UINib(nibName:"CustomTrailerDefectsTableViewCell",bundle:nil),forCellReuseIdentifier:"TrailerDefectsCell");
        tableView.dataSource = self
        tableView.delegate = self
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
        let rightButton  = UIBarButtonItem(title: "Done", style: .plain, target: self, action: #selector(rightButtonTapped(sender:)))
        self.navigationItem.rightBarButtonItem = rightButton
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
        print("chinna")
    }
    func textFieldDidEndEditing(_ textField: UITextField) {
        trailerComments.setObject(textField.text!, forKey: textField.tag as NSCopying)
        
    }

    
}
    /*
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)

        // Configure the cell...

        return cell
    }
    */

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    

