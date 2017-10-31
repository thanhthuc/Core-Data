//
//  SaveAccessDelete.swift
//  ShoutOut
//
//  Created by Andrew Bancroft on 1/22/17.
//  Copyright © 2017 pluralsight. All rights reserved.
//

import XCTest
import CoreData

@testable import ShoutOut

class SaveAccessDelete: XCTestCase {
	var managedObjectContext: NSManagedObjectContext!
	var dataService: DataService!
	
	override func setUp() {
		super.setUp()
		// Put setup code here. This method is called before the invocation of each test method in the class.
		self.managedObjectContext = createMainContextInMemory()
		self.dataService = DataService(managedObjectContext: managedObjectContext)
		self.dataService.seedEmployees()
	}
	
	override func tearDown() {
		// Put teardown code here. This method is called after the invocation of each test method in the class.
		super.tearDown()
	}
	
	func testExample() {
		// This is an example of a functional test case.
		// Use XCTAssert and related functions to verify your tests produce the correct results.
	}
	
	func testPerformanceExample() {
		// This is an example of a performance test case.
		self.measure {
			// Put the code you want to measure the time of here.
		}
	}
	
	func testFetchAllEmployees() {
		let employeeFetchRequest = NSFetchRequest<Employee>(entityName: Employee.entityName)
		
		do {
			let employees = try managedObjectContext.fetch(employeeFetchRequest)
			print(employees)
		} catch {
			print("Something went wrong fetching employees: \(error)")
		}
	}
	
	func testFilterShoutOuts() {
		seedShoutOutsForTesting(managedObjectContext: managedObjectContext)
		
		let shoutOutsFetchRequest = NSFetchRequest<ShoutOut>(entityName: ShoutOut.entityName)
		let shoutCategoryEqualityPredicate = NSPredicate(format: "%K == %@", #keyPath(ShoutOut.shoutCategory), "Great Job!")
		shoutOutsFetchRequest.predicate = shoutCategoryEqualityPredicate
		
		do {
			let filteredShoutOuts = try managedObjectContext.fetch(shoutOutsFetchRequest)
			print("----------First Result Set----------")
			printShoutOuts(shoutOuts: filteredShoutOuts)
		} catch {
			print("Something went wrong fetching ShoutOuts: \(error)")
		}
		
		let shoutCategoryINPredicate = NSPredicate(format: "%K IN %@", #keyPath(ShoutOut.shoutCategory), "Great Job!, Well Done!")
		shoutOutsFetchRequest.predicate = shoutCategoryINPredicate
		
		do {
			let filteredShoutOuts = try managedObjectContext.fetch(shoutOutsFetchRequest)
			print("----------Second Result Set----------")
			printShoutOuts(shoutOuts: filteredShoutOuts)
		} catch {
			print("Something went wrong fetching ShoutOuts: \(error)")
		}
		
		let beginsWithPredicate = NSPredicate(format: "%K BEGINSWITH %@", #keyPath(ShoutOut.toEmployee.lastName), "Rodrig")
		shoutOutsFetchRequest.predicate = beginsWithPredicate
		
		do {
			let filteredShoutOuts = try managedObjectContext.fetch(shoutOutsFetchRequest)
			print("----------Third Result Set----------")
			printShoutOuts(shoutOuts: filteredShoutOuts)
		} catch {
			print("Something went wrong fetching ShoutOuts: \(error)")
		}
	}
	
	func seedShoutOutsForTesting(managedObjectContext: NSManagedObjectContext) {
		let employeeFetchRequest = NSFetchRequest<Employee>(entityName: Employee.entityName)
		
		do {
			let employees = try managedObjectContext.fetch(employeeFetchRequest)
			
			let shoutOut1 = NSEntityDescription.insertNewObject(forEntityName: ShoutOut.entityName,
			                                                    into: managedObjectContext) as! ShoutOut
			shoutOut1.shoutCategory = "Great Job!"
			shoutOut1.message = "Hey, great job on that project!"
			shoutOut1.toEmployee = employees[0]
			
			let shoutOut2 = NSEntityDescription.insertNewObject(forEntityName: ShoutOut.entityName,
			                                                    into: managedObjectContext) as! ShoutOut
			shoutOut2.shoutCategory = "Great Job!"
			shoutOut2.message = "Couldn't have presented better at the conference last week!"
			shoutOut2.toEmployee = employees[1]
			
			let shoutOut3 = NSEntityDescription.insertNewObject(forEntityName: ShoutOut.entityName,
			                                                    into: managedObjectContext) as! ShoutOut
			shoutOut3.shoutCategory = "Awesome Work!"
			shoutOut3.message = "You always do awesome work!"
			shoutOut3.toEmployee = employees[2]
			
			let shoutOut4 = NSEntityDescription.insertNewObject(forEntityName: ShoutOut.entityName,
			                                                    into: managedObjectContext) as! ShoutOut
			shoutOut4.shoutCategory = "Awesome Work!"
			shoutOut4.message = "You've done an amazing job this year!"
			shoutOut4.toEmployee = employees[3]
			
			let shoutOut5 = NSEntityDescription.insertNewObject(forEntityName: ShoutOut.entityName,
			                                                    into: managedObjectContext) as! ShoutOut
			shoutOut5.shoutCategory = "Well Done!"
			shoutOut5.message = "I'm impressed with the results of your prototoype!"
			shoutOut5.toEmployee = employees[4]
			
			let shoutOut6 = NSEntityDescription.insertNewObject(forEntityName: ShoutOut.entityName,
			                                                    into: managedObjectContext) as! ShoutOut
			shoutOut6.shoutCategory = "Well Done!"
			shoutOut6.message = "Keep up the good work!"
			shoutOut6.toEmployee = employees[5]
			
			do {
				try managedObjectContext.save()
			} catch {
				print("Something went wrong with saving ShoutOuts: \(error)")
				managedObjectContext.rollback()
			}
		} catch {
			print("Something went wrong fetching employees: \(error)")
		}
	}
	
	func testSortShoutOuts() {
		seedShoutOutsForTesting(managedObjectContext: managedObjectContext)
		
		let shoutOutsFetchRequest = NSFetchRequest<ShoutOut>(entityName: ShoutOut.entityName)
		
		do {
			let shoutOuts = try managedObjectContext.fetch(shoutOutsFetchRequest)
			print("----------Unsorted ShoutOuts----------")
			printShoutOuts(shoutOuts: shoutOuts)
		} catch _ {}
		
		let shoutCategorySortDescriptor = NSSortDescriptor(key: #keyPath(ShoutOut.shoutCategory), ascending: true)
		let lastNameSortDescriptor = NSSortDescriptor(key: #keyPath(ShoutOut.toEmployee.lastName), ascending: true)
		let firstNameSortDescriptor = NSSortDescriptor(key: #keyPath(ShoutOut.toEmployee.firstName), ascending: true)
		
		shoutOutsFetchRequest.sortDescriptors = [shoutCategorySortDescriptor, lastNameSortDescriptor, firstNameSortDescriptor]
		
		do {
			let shoutOuts = try managedObjectContext.fetch(shoutOutsFetchRequest)
			print("----------Sorted ShoutOuts----------")
			printShoutOuts(shoutOuts: shoutOuts)
		} catch _ {}
	}
	
	func printShoutOuts(shoutOuts: [ShoutOut]) {
		for shoutOut in shoutOuts {
			print("\n----------ShoutOut----------")
			print("Shout Category: \(shoutOut.shoutCategory)")
			print("Message: \(shoutOut.message)")
			print("To: \(shoutOut.toEmployee.firstName) \(shoutOut.toEmployee.lastName)")
		}
	}
}



















