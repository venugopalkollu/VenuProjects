//
//  CustomTruckDefectsTableViewCell.swift
//  DVIRform
//
//  Created by Lirctek on 09/06/17.
//  Copyright © 2017 Lirctek. All rights reserved.
//

import UIKit
@objc protocol CheckBoxSelectded{
    func isCheckBoxSelected(index:Int)
}

class CustomTruckDefectsTableViewCell: UITableViewCell,UITextFieldDelegate {
    
    var checkBoxDelegate:CheckBoxSelectded?
    
    @IBOutlet weak var checkBoxButton: UIButton!
    
    @IBOutlet weak var truckDefectLabel: UILabel!
    
    @IBOutlet weak var txtComments: UITextField!
    
    @IBOutlet weak var lblComments: UILabel!
    var checkBox = UIImage(named: "checkBox-Checked.png")
    var uncheckBox = UIImage(named: "checkbox-unchecked.png")
    var isboxClicked:Bool!
  //  txtComments.delegate = self
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
         isboxClicked = false
    
        
        
    }
        
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    @IBAction func checkBoxButtonClicked(_ sender: Any) {
        let button = sender as! UIButton
        self.checkBoxDelegate?.isCheckBoxSelected(index: button.tag)
    }
    
   }
    
    

