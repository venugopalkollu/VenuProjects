//
//  View3.swift
//  DVIRform
//
//  Created by Lirctek on 30/05/17.
//  Copyright © 2017 Lirctek. All rights reserved.
//

import UIKit
import CoreGraphics
class View3: UIView {

    class func instanceFromNib() -> UIView {
        return UINib(nibName: "View3", bundle: nil).instantiate(withOwner: nil, options: nil)[0] as! View3
    }
    
    var completionHandler:((_ slectedIndex:Int)->Void)?


    @IBOutlet weak var driverSignatureView: UIImageView!
    
    @IBOutlet weak var mechanicSignatureView: UIImageView!
    
    
    @IBOutlet weak var signatureSaveButton: UIButton!
    
    @IBAction func saveButtonClicked(_ sender: UIButton) {
        
        self.completionHandler!(3)
        
    }
    
    
    //Drawing Part
    var lastPoint:CGPoint!
    var isSwiping:Bool!
    var red:CGFloat!
    var green:CGFloat!
    var blue:CGFloat!
    
    //MARK: Touch events
    
    override func touchesBegan(_ touches: Set<UITouch>,
                               with event: UIEvent?){
        isSwiping    = false
        if let touch = touches.first{
            lastPoint = touch.location(in: driverSignatureView)
        }
    }
    
    override func touchesMoved(_ touches: Set<UITouch>,
                               with event: UIEvent?){
        
        isSwiping = true;
        if let touch = touches.first{
            let currentPoint = touch.location(in: driverSignatureView)
            UIGraphicsBeginImageContext(self.driverSignatureView.frame.size)
            self.driverSignatureView.image?.draw(in: CGRect(x: 0, y: 0, width: self.driverSignatureView.frame.size.width, height: self.driverSignatureView.frame.size.height))
            UIGraphicsGetCurrentContext()?.move(to: CGPoint(x: lastPoint.x, y: lastPoint.y))
            UIGraphicsGetCurrentContext()?.addLine(to: CGPoint(x: currentPoint.x, y: currentPoint.y))
            UIGraphicsGetCurrentContext()?.setLineCap(CGLineCap.round)
            UIGraphicsGetCurrentContext()?.setLineWidth(2.0)
//    UIGraphicsGetCurrentContext()?.setStrokeColor(red: red, green: green, blue: blue, alpha: 1.0)
            UIGraphicsGetCurrentContext()?.strokePath()
            self.driverSignatureView.image = UIGraphicsGetImageFromCurrentImageContext()
            UIGraphicsEndImageContext()
            lastPoint = currentPoint
        }
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?){
        if(!isSwiping) {
            // This is a single touch, draw a point
            UIGraphicsBeginImageContext(self.driverSignatureView.frame.size)
            self.driverSignatureView.image?.draw(in: CGRect(x: 0, y: 0, width: self.driverSignatureView.frame.size.width, height: self.driverSignatureView.frame.size.height))
            UIGraphicsGetCurrentContext()?.setLineCap(CGLineCap.round)
            UIGraphicsGetCurrentContext()?.setLineWidth(9.0)
            UIGraphicsGetCurrentContext()?.setStrokeColor(red: red, green: green, blue: blue, alpha: 1.0)
            UIGraphicsGetCurrentContext()?.move(to: CGPoint(x: lastPoint.x, y: lastPoint.y))
            UIGraphicsGetCurrentContext()?.addLine(to: CGPoint(x: lastPoint.x, y: lastPoint.y))
            UIGraphicsGetCurrentContext()?.strokePath()
            self.driverSignatureView.image = UIGraphicsGetImageFromCurrentImageContext()
            UIGraphicsEndImageContext()
        }
    }
    
    
/*    override func touchesBegan(_ touches: Set<UITouch>,
                               with event: UIEvent?){
        isSwiping    = false
        if let touch = touches.first{
            lastPoint = touch.location(in: mechanicSignatureView)
        }
    }
    
    override func touchesMoved(_ touches: Set<UITouch>,
                               with event: UIEvent?){
        
        isSwiping = true;
        if let touch = touches.first{
            let currentPoint = touch.location(in: mechanicSignatureView)
            UIGraphicsBeginImageContext(self.mechanicSignatureView.frame.size)
            self.mechanicSignatureView.image?.draw(in: CGRect(x: 0, y: 0, width: self.mechanicSignatureView.frame.size.width, height: self.mechanicSignatureView.frame.size.height))
            UIGraphicsGetCurrentContext()?.move(to: CGPoint(x: lastPoint.x, y: lastPoint.y))
            UIGraphicsGetCurrentContext()?.addLine(to: CGPoint(x: currentPoint.x, y: currentPoint.y))
            UIGraphicsGetCurrentContext()?.setLineCap(CGLineCap.round)
            UIGraphicsGetCurrentContext()?.setLineWidth(2.0)
            //    UIGraphicsGetCurrentContext()?.setStrokeColor(red: red, green: green, blue: blue, alpha: 1.0)
            UIGraphicsGetCurrentContext()?.strokePath()
            self.mechanicSignatureView.image = UIGraphicsGetImageFromCurrentImageContext()
            UIGraphicsEndImageContext()
            lastPoint = currentPoint
        }
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?){
        if(!isSwiping) {
            // This is a single touch, draw a point
            UIGraphicsBeginImageContext(self.driverSignatureView.frame.size)
            self.mechanicSignatureView.image?.draw(in: CGRect(x: 0, y: 0, width: self.mechanicSignatureView.frame.size.width, height: self.mechanicSignatureView.frame.size.height))
            UIGraphicsGetCurrentContext()?.setLineCap(CGLineCap.round)
            UIGraphicsGetCurrentContext()?.setLineWidth(9.0)
 //         UIGraphicsGetCurrentContext()?.setStrokeColor(red: red, green: green, blue: blue, alpha: 1.0)
            UIGraphicsGetCurrentContext()?.move(to: CGPoint(x: lastPoint.x, y: lastPoint.y))
            UIGraphicsGetCurrentContext()?.addLine(to: CGPoint(x: lastPoint.x, y: lastPoint.y))
            UIGraphicsGetCurrentContext()?.strokePath()
            self.mechanicSignatureView.image = UIGraphicsGetImageFromCurrentImageContext()
            UIGraphicsEndImageContext()
        }
    }
    
*/
    

    
}
