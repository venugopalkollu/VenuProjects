//
//  View2.swift
//  DVIRform
//
//  Created by Lirctek on 30/05/17.
//  Copyright © 2017 Lirctek. All rights reserved.
//

import UIKit

@objc protocol DefectsTableView{
    
    func showDefectesTableView()
    
    
}
@objc protocol AnotherDefectsTableView{
    func showAnotherDefectsTableView()

}

class View2: UIView,UITextFieldDelegate {
    var completionHandler:((_ slectedIndex:Int)->Void)?
    class func instanceFromNib() -> UIView{
        return UINib(nibName: "View2", bundle: nil).instantiate(withOwner: nil, options: nil)[0] as! View2
    }
    var truckDelegate:DefectsTableView?
    var trailerDelegate:AnotherDefectsTableView?
    
    @IBOutlet weak var txtTruckNumber: UITextField!
    
    @IBOutlet weak var txtAddRemoveTruckDefects: UITextField!
    
    @IBOutlet weak var txtTrailerNumber: UITextField!
    
    @IBOutlet weak var txtAddRemoveTrailerDefects: UITextField!

    @IBOutlet weak var vehicleSaveButton: UIButton!
    
    func setDelegates(){
        self.txtAddRemoveTruckDefects.delegate = self;
        self.txtAddRemoveTrailerDefects.delegate = self;
        
    }
    
    
    @IBAction func vehicleSaveButtonClicked(_ sender: Any) {
        self.completionHandler!(2)

        
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
            }
    
    func showTableView(){
        self.truckDelegate?.showDefectesTableView()
        
    }
    func showAnotherTableView(){
        self.trailerDelegate?.showAnotherDefectsTableView()
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
    
    }
    
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        if textField == self.txtAddRemoveTruckDefects{
            showTableView()
        }
        else if textField == self.txtAddRemoveTrailerDefects{
            showAnotherTableView()
        }
        return false;
    }
 
    /*
     @IBAction func vehicleSaveButtonClicked(_ sender: Any) {
     }
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

}
