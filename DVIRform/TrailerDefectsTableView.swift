//
//  TrailerDefectsTableView.swift
//  DVIRform
//
//  Created by Lirctek on 12/06/17.
//  Copyright © 2017 Lirctek. All rights reserved.
//

import UIKit

class TrailerDefectsTableView: UIView, UITableViewDelegate,UITableViewDataSource, TrailerCheckBoxSelectded, UITextFieldDelegate {
    
    @IBOutlet weak var trailerTableView: UITableView!

    @IBOutlet weak var backButton: UIBarButtonItem!
    @IBOutlet weak var doneButton: UIBarButtonItem!
    var trailerDefects :NSMutableArray = []
    var selectedIndexArrayForTrailer: NSMutableArray = []
    
    class func instanceFromNib() -> UIView {
        return UINib(nibName: "TrailerDefectsTableView", bundle: nil).instantiate(withOwner: nil, options: nil)[0] as! TrailerDefectsTableView
    }
    
    func allocateTrailerArray(){
        trailerDefects = ["Brake Connections", "Brakes", "Coupling Devices", "Coupling Pin", "Doors", "Hitch", "Landing Gear", "Lights", "Reflectors", "Roof", "Straps", "Suspection System", "Tarpaulin", "Tires", "Wheels & Rims", "Other"]
        
        self.trailerTableView?.register(UINib(nibName:"CustomTrailerDefectsTableViewCell",bundle:nil),forCellReuseIdentifier:"TrailerDefectsCell");
        trailerTableView.dataSource = self
        trailerTableView.delegate = self
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return trailerDefects.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TrailerDefectsCell", for: indexPath) as! CustomTrailerDefectsTableViewCell
        cell.checkBoxDelegateForTrailer = self
        cell.trailerDefectsLabel?.text = trailerDefects[indexPath.row] as? String
        if selectedIndexArrayForTrailer.contains(indexPath.row){
            
            cell.trailerCheckBoxButton.setImage(cell.checkBox, for: UIControlState.normal)
            cell.txtTrailerComments.isHidden = false
            cell.lblTrailerComments.isHidden = false
        }else{
            cell.trailerCheckBoxButton.setImage(cell.uncheckBox, for: UIControlState.normal)
            cell.txtTrailerComments.isHidden = true
            cell.lblTrailerComments.isHidden = true
        }
        cell.trailerCheckBoxButton.tag = indexPath.row
        
        let defect = trailerDefects[indexPath.row]                                                                                                                                                                                                                                                                                                                                                               
        return cell;
    }
    
    func isCheckBoxSelectedForTrailer(index:Int){
        if selectedIndexArrayForTrailer.contains(index){
            self.selectedIndexArrayForTrailer.remove(index)
            let indexPath = IndexPath(item: index, section: 0)
            trailerTableView.reloadRows(at: [indexPath], with: .automatic)
         }else{
            self.selectedIndexArrayForTrailer.add(index)
            let indexPath = IndexPath(item: index, section: 0)
            trailerTableView.reloadRows(at: [indexPath], with: .automatic)

        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if selectedIndexArrayForTrailer.contains(indexPath.row){
            return 82
        }
        else{
            return 50
        }
        
    }
    
}

    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */


