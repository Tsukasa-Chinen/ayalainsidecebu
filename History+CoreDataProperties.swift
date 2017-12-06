//
//  History+CoreDataProperties.swift
//  ayalaInsideCebu
//
//  Created by Tsukasa Chinen on 2017/12/05.
//  Copyright © 2017年 Tsukasa Chinen. All rights reserved.
//
//

import Foundation
import CoreData


extension History {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<History> {
        return NSFetchRequest<History>(entityName: "History")
    }

    @NSManaged public var shopID: Int16
    @NSManaged public var id: Int16
    @NSManaged public var date: NSDate?

}
