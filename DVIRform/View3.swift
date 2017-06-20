//
//  View3.swift
//  DVIRform
//
//  Created by Lirctek on 30/05/17.
//  Copyright © 2017 Lirctek. All rights reserved.
//

import UIKit
import CoreGraphics
class View3: UIView, YPSignatureDelegate {

    class func instanceFromNib() -> UIView {
        return UINib(nibName: "View3", bundle: nil).instantiate(withOwner: nil, options: nil)[0] as! View3
    }

    @IBOutlet weak var driverSignatureView: UIImageView!
    
    @IBOutlet weak var mechanicSignatureView: UIImageView!
    
    
    @IBOutlet weak var signatureSaveButton: UIButton!
    
    @IBAction func saveButtonClicked(_ sender: UIButton) {
        
    }
    func setDelegates(){
       // self.driverSignatureView.delegate = self;
      //  self.mechanicSignatureView.delegate = self;
        
    }
    

        func didStart() {
        print("Started Drawing")
    }
    
    // didFinish() is called rigth after the last touch of a gesture is registered in the view.
    // Can be used to enabe scrolling in a scroll view if it has previous been disabled.
    func didFinish() {
        print("Finished Drawing")
    }

    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

}
