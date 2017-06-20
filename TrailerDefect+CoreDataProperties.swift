//
//  TrailerDefect+CoreDataProperties.swift
//  DVIRform
//
//  Created by Lirctek on 19/06/17.
//  Copyright © 2017 Lirctek. All rights reserved.
//

import Foundation
import CoreData


extension TrailerDefect {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<TrailerDefect> {
        return NSFetchRequest<TrailerDefect>(entityName: "TrailerDefect")
    }

    @NSManaged public var createdAt: NSDate?
    @NSManaged public var createdUserId: Int16
    @NSManaged public var id: Int16
    @NSManaged public var name: String?
    @NSManaged public var updatedAt: NSDate?
    @NSManaged public var updatedUserId: Int16
    @NSManaged public var dvirTrailerDefectMapping: DvirTrailerDefectMapping?

}
