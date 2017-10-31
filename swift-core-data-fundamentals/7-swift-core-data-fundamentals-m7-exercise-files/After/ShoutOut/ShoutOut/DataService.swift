//
//  DataService.swift
//  ShoutOut
//
//  Created by Andrew Bancroft on 12/27/16.
//  Copyright © 2016 pluralsight. All rights reserved.
//

import Foundation
import CoreData

struct DataService: ManagedObjectContextDependentType {
	var managedObjectContext: NSManagedObjectContext!
	
	func seedEmployees() {
		let employeeFetchRequest = NSFetchRequest<Employee>(entityName: Employee.entityName)
		
		do {
			let employees = try self.managedObjectContext.fetch(employeeFetchRequest)
			let employeesAlreadySeeded = employees.count > 0
			
			if(employeesAlreadySeeded == false) {
				
				
				let employee1 = NSEntityDescription.insertNewObject(forEntityName: Employee.entityName,
				                                                    into: self.managedObjectContext) as! Employee
				employee1.firstName = "Jane"
				employee1.lastName = "Sherman"
				employee1.department = "Accounting"
				
				let employee2 = NSEntityDescription.insertNewObject(forEntityName: Employee.entityName,
				                                                    into: self.managedObjectContext) as! Employee
				employee2.firstName = "Luke"
				employee2.lastName = "Jones"
				employee2.department = "Accounting"
				
				let employee3 = NSEntityDescription.insertNewObject(forEntityName: Employee.entityName,
				                                                    into: self.managedObjectContext) as! Employee
				employee3.firstName = "Kathy"
				employee3.lastName = "Smith"
				employee3.department = "Information Technology"
				
				let employee4 = NSEntityDescription.insertNewObject(forEntityName: Employee.entityName,
				                                                    into: self.managedObjectContext) as! Employee
				employee4.firstName = "Jerome"
				employee4.lastName = "Rodriguez"
				employee4.department = "Information Technology"
				
				let employee5 = NSEntityDescription.insertNewObject(forEntityName: Employee.entityName,
				                                                    into: self.managedObjectContext) as! Employee
				employee5.firstName = "Maria"
				employee5.lastName = "Tillman"
				employee5.department = "Legal"
				
				let employee6 = NSEntityDescription.insertNewObject(forEntityName: Employee.entityName,
				                                                    into: self.managedObjectContext) as! Employee
				employee6.firstName = "Paul"
				employee6.lastName = "O'Brian"
				employee6.department = "Legal"
				
				do {
					try self.managedObjectContext.save()
				} catch {
					print("Something went wrong: \(error)")
					self.managedObjectContext.rollback()
				}
			} else {
				for employee in employees {
					switch employee.lastName {
					case "Sherman":
						employee.department = "Accounting"
					case "Jones":
						employee.department = "Accounting"
					case "Smith":
						employee.department = "Information Technology"
					case "Rodriguez":
						employee.department = "Information Technology"
					case "Tillman":
						employee.department = "Legal"
					case "O'Brian":
						employee.department = "Legal"
					default:
						break
					}
				}
				
				do {
					try self.managedObjectContext.save()
				} catch {}
			}
		} catch {}
	}
}
