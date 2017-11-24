//
//  Shoutout.swift
//  Core-Data
//
//  Created by Thuc on 11/12/17.
//  Copyright © 2017 Thuc. All rights reserved.
//

import Foundation
import CoreData

class ShoutOut: NSManagedObject {
    @NSManaged var from: String?
    @NSManaged var message: String?
    @NSManaged var shoutCategory: String
    @NSManaged var sentOn: Date?
    @NSManaged var toEmployee: Employee
    
    static var entityName: String {
        return "ShoutOut"
    }
}
