//
//  CameraViewController.swift
//  ScannerView
//
//  Created by chinnababu kamanuri on 16/06/17.
//  Copyright © 2017 chinnababu kamanuri. All rights reserved.
//

import UIKit

//enum IPDFCameraViewType:NSInteger {
//    case IPDFCameraViewTypeBlackAndWhite
//    case IPDFCvarraViewTypeNormal
//}
class CameraViewController: UIViewController {

    @IBOutlet weak var cameraViewController: IPDFCameraViewController!
    @IBOutlet weak var focusIndicator: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    var imageView = ImageViewController()

    override func viewDidLoad() {
        super.viewDidLoad()
        cameraViewController.setupCameraView()
        cameraViewController.isBorderDetectionEnabled = true
        cameraViewController.cameraViewType = IPDFCameraViewType.normal
        updateTitleLabel()
        self.navigationController?.navigationBar.isTranslucent = false;

    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.cameraViewController.start()
    }

    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidAppear(animated);
        self.cameraViewController.stop();
    }

    @IBAction func captureButton(_ sender: Any){
        weak var weakSelf: CameraViewController? = self
        cameraViewController.captureImage(completionHander: {(_ imageFilePath) -> Void in
            weakSelf?.imageView.path = imageFilePath!
            weakSelf?.imageView.isRetake = true;
            weakSelf?.navigationController?.pushViewController((weakSelf?.imageView)!, animated: true)
        })
    }

    func focusIndicatorAnimate(to targetPoint: CGPoint) {
        focusIndicator.center = targetPoint
        focusIndicator.alpha = 0.0
        focusIndicator.isHidden = false
        UIView.animate(withDuration: 0.4, animations: {() -> Void in
            self.focusIndicator.alpha = 1.0
        }, completion: {(_ finished: Bool) -> Void in
            UIView.animate(withDuration: 0.4, animations: {() -> Void in
                self.focusIndicator.alpha = 0.0
            })
        })
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func focusGesture(_ sender: UITapGestureRecognizer) {
        if sender.state == UIGestureRecognizerState.recognized {
            let location: CGPoint = (sender as AnyObject).location(in: cameraViewController)
            focusIndicatorAnimate(to: location)
            cameraViewController.focus(at: location, completionHandler: {() -> Void in
                self.focusIndicatorAnimate(to: location)
            })
        }
    }

    @IBAction func filterToggle(_ sender: Any) {
        cameraViewController.cameraViewType = (cameraViewController.cameraViewType == IPDFCameraViewType.blackAndWhite) ? IPDFCameraViewType.normal : IPDFCameraViewType.blackAndWhite
        updateTitleLabel()
    }

    @IBAction func torchToggle(_ sender: Any) {
        let enable: Bool = !cameraViewController.isTorchEnabled
        change(sender as! UIButton, targetTitle: (enable) ? "FLASH On" : "FLASH Off", toStateEnabled: enable)
        cameraViewController.isTorchEnabled = enable
    }

    func dismissPreview(_ dismissTap: UITapGestureRecognizer) {
        UIView.animate(withDuration: 0.7, delay: 0.0, usingSpringWithDamping: 0.8, initialSpringVelocity: 1.0, options: .allowUserInteraction, animations: {() -> Void in
            dismissTap.view?.frame = self.view.bounds.offsetBy(dx: CGFloat(0), dy: CGFloat(self.view.bounds.size.height))
        }, completion: {(_ finished: Bool) -> Void in
            dismissTap.view?.removeFromSuperview()
        })
    }

    func updateTitleLabel() {
        let animation = CATransition()
        animation.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseOut)
        animation.type = kCATransitionPush
        animation.subtype = kCATransitionFromBottom
        animation.duration = 0.35
        titleLabel?.layer.add(animation, forKey: "kCATransitionFade")
        let filterMode: String = (cameraViewController.cameraViewType == IPDFCameraViewType.blackAndWhite) ? "TEXT FILTER" : "COLOR FILTER"
        titleLabel?.text = filterMode + (" | \((cameraViewController.isBorderDetectionEnabled) ? "AUTOCROP On" : "AUTOCROP Off")")
    }

    @IBAction func borderDetectToggle(_ sender: Any) {
        let enable: Bool = !cameraViewController.isBorderDetectionEnabled
        change(sender as! UIButton, targetTitle: (enable) ? "CROP On" : "CROP Off", toStateEnabled: enable)
        cameraViewController.isBorderDetectionEnabled = enable
        updateTitleLabel()
    }
    // MARK: - Navigation

    func change(_ button: UIButton, targetTitle title: String, toStateEnabled enabled: Bool) {
        button.setTitle(title, for: .normal)
        button.setTitleColor((enabled) ? UIColor(red: CGFloat(1), green: CGFloat(0.81), blue: CGFloat(0), alpha: CGFloat(1)) : UIColor.white, for: .normal)
    }
}
