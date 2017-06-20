//
//  DvirTruckDefectMapping+CoreDataProperties.swift
//  DVIRform
//
//  Created by Lirctek on 19/06/17.
//  Copyright © 2017 Lirctek. All rights reserved.
//

import Foundation
import CoreData


extension DvirTruckDefectMapping {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<DvirTruckDefectMapping> {
        return NSFetchRequest<DvirTruckDefectMapping>(entityName: "DvirTruckDefectMapping")
    }

    @NSManaged public var comment: String?
    @NSManaged public var createdAt: NSDate?
    @NSManaged public var createdUserId: Int16
    @NSManaged public var dvirId: Int16
    @NSManaged public var id: Int16
    @NSManaged public var lastsyncAt: NSDate?
    @NSManaged public var serverId: Int16
    @NSManaged public var syncRequired: Int16
    @NSManaged public var truckId: Int16
    @NSManaged public var updatedAt: NSDate?
    @NSManaged public var updatedFields: String?
    @NSManaged public var updatedUserId: Int16
    @NSManaged public var truckDefect: TruckDefect?

}
