//
//  Dvir+CoreDataProperties.swift
//  DVIRform
//
//  Created by Lirctek on 19/06/17.
//  Copyright © 2017 Lirctek. All rights reserved.
//

import Foundation
import CoreData


extension Dvir {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Dvir> {
        return NSFetchRequest<Dvir>(entityName: "Dvir")
    }

    @NSManaged public var carrier: String?
    @NSManaged public var createdAt: NSDate?
    @NSManaged public var defectsCorrected: Int16
    @NSManaged public var driverSignature: NSData?
    @NSManaged public var id: Int16
    @NSManaged public var lastSyncAt: String?
    @NSManaged public var location: String?
    @NSManaged public var mechanicSignature: NSData?
    @NSManaged public var odometer: Int16
    @NSManaged public var serverId: Int16
    @NSManaged public var syncRequired: Int16
    @NSManaged public var time: NSDate?
    @NSManaged public var trailerNumber: String?
    @NSManaged public var truckNumber: String?
    @NSManaged public var updatedAt: NSDate?
    @NSManaged public var updatedFields: String?
    @NSManaged public var userId: Int16
    @NSManaged public var elogDate: NSDate?
}
