//
//  Employee.swift
//  Core-Data
//
//  Created by Thuc on 11/12/17.
//  Copyright © 2017 Thuc. All rights reserved.
//
import Foundation
import CoreData

class Employee: NSManagedObject {
    @NSManaged var firstName: String
    @NSManaged var lastName: String
    @NSManaged var shoutOuts: NSSet?
    
    static var entityName: String {
        return "Employee"
    }
}
