//
//  ViewController.swift
//  MYAWS
//
//  Created by chinnababu kamanuri on 23/06/17.
//  Copyright © 2017 chinnababu kamanuri. All rights reserved.
//

import UIKit
import AWSS3
import AWSDynamoDB

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

  
    @IBAction func startScan(_ sender: Any) {
        
        let camObj = CameraViewController()
        self.navigationController?.pushViewController(camObj, animated: true);
        
    }
}

