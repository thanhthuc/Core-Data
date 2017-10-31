//
//  ShoutOut.swift
//  ShoutOut
//
//  Created by Andrew Bancroft on 12/22/16.
//  Copyright © 2016 pluralsight. All rights reserved.
//

import Foundation
import CoreData

class ShoutOut: NSManagedObject {
	@NSManaged var from: String?
	@NSManaged var message: String?
	@NSManaged var sentDate: Date?
	@NSManaged var shoutCategory: String
	
	@NSManaged var toEmployee: Employee
	
	static var entityName: String { return "ShoutOut" }
}
