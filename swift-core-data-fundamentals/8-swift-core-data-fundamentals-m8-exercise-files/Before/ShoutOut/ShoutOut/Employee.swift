//
//  Employee.swift
//  ShoutOut
//
//  Created by Andrew Bancroft on 12/24/16.
//  Copyright © 2016 pluralsight. All rights reserved.
//

import Foundation
import CoreData

class Employee: NSManagedObject {
	@NSManaged var firstName: String
	@NSManaged var lastName: String
	@NSManaged var department: String
	
	@NSManaged var shoutOuts: NSSet?
	
	static var entityName: String { return "Employee" }
}
