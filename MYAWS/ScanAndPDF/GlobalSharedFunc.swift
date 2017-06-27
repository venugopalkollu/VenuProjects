//
//  GlobalSharedFunc.swift
//  ScannerView
//
//  Created by chinnababu kamanuri on 17/06/17.
//  Copyright © 2017 chinnababu kamanuri. All rights reserved.
//

import Foundation
open class GlobalSharedFunc {
    var imagePaths = [UIImage]()

open class var sharedManager: GlobalSharedFunc {
    struct Static {
        static let instance: GlobalSharedFunc = GlobalSharedFunc()
    }
    return Static.instance
}
}
