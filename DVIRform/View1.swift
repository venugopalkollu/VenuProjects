//
//  View1.swift
//  DVIRform
//
//  Created by Lirctek on 30/05/17.
//  Copyright © 2017 Lirctek. All rights reserved.
//

import UIKit
import CoreData


@objc protocol saveButtonClicked{
    
}

class View1: UIView,UITextFieldDelegate {

    class func instanceFromNib() -> UIView {
        return UINib(nibName: "View1", bundle: nil).instantiate(withOwner: nil, options: nil)[0] as! View1
    }
    var completionHandler:((_ slectedIndex:Int)->Void)?

    @IBOutlet weak var txtCarrier: UITextField!
    
    @IBOutlet weak var txtLocation: UITextField!
    
    @IBOutlet weak var txtOdometer: UITextField!
    
    
    @IBOutlet weak var saveButton: UIButton!
    
    
    
    
    
    
    
    
    
    @IBAction func saveButtonClicked(_ sender: Any) {
        
 self.completionHandler!(1)
            }
    
    
    /*
    // Only override draw() if you perform custom drawing.
     @IBOutlet weak var vbtton: UIButton!
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

}
